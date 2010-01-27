//
//  ContextService.m
//  ContextFramework
//
//  Created by Felix on 11.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context service class, the main class of the context framework.
//

#import "ContextService.h"


@implementation ContextService

@synthesize contextSources;
@synthesize contextSourcePool;
@synthesize contexts;

- (id)init {
	
    self = [super init];
    if (self != nil) {
				
		// Names of all context sources
		NSArray *contextSourceNames = [NSArray arrayWithObjects:@"Device : Location", @"Device : Time", @"Device : Orientation", @"Device : Network", @"Remote : GeoIP", @"Remote : Weather", @"User : Identity", @"User : Activity", nil];
		
		// Classes of all context sourves
		NSArray *contextSourceClasses = [NSArray arrayWithObjects: @"LocationContextSource", @"TimeContextSource", @"OrientationContextSource", @"NetworkContextSource", @"RemoteHostContextSource", @"RemoteWeatherContextSource", @"UserIdentityContextSource", @"UserActivityContextSource", nil];
		
		// Create a pool dictionary of all available context sources
		self.contextSourcePool = [NSDictionary dictionaryWithObjects:contextSourceClasses forKeys:contextSourceNames];
		
		// Create a dictionary of all active context sources
		self.contextSources = [[NSMutableDictionary alloc] init];
				
		// Configure ObjectiveResource
		[ObjectiveResourceConfig setSite:@"http://contextserver.felixmueller.name/"];
		//[ObjectiveResourceConfig setSite:@"http://localhost:4567/"];
		[ObjectiveResourceConfig setUser:@"none"];
		[ObjectiveResourceConfig setPassword:@"none"];
		[ObjectiveResourceConfig setResponseType:XmlResponse];

    }
    return self;
	
}

- (NSArray *)getUsers {
	
	// not yet implemented!
	
	return nil;
	
}

- (BOOL)addUser:(NSString *)userName {

	// not yet implemented!
	
	return NO;

}

- (BOOL)removeUser:(NSString *)userName {

	// not yet implemented!
	
	return NO;
}

- (NSDictionary *)getContexts {

	// Delegate call to method "getContextsForUser:"
	return [self getContextsForUser:nil];
}

- (NSDictionary *)getContextsForUser:(NSString *)userName {
	
	// Delegate call to method "getContextsForUser:withType:"
	return [self getContextsForUser:userName withType:nil];

}

- (NSDictionary *)getContextsForUser:(NSString *)userName withType:(NSString *)contextType {

	// Get all source attributes containing their current values
	NSDictionary *attributes = [self getSourceAttributes];
	
	// Get all source attribute keys
	NSArray *attributeKeys = [NSArray arrayWithArray:[attributes allKeys]];
	
	// Prepare the attribute parameter string with format {'attribute'=>'value','attribute'=>'value', ...}
	NSString *attributeParameterString = [[NSString alloc] init];
	
	// If there are attributes
	if ([attributeKeys count] > 0) {
		
		// Add the opening bracket
		attributeParameterString = [attributeParameterString stringByAppendingString:@"{"];
		
		// Iterate all context attributes
		for(NSString *attributeKey in attributeKeys) {
			
			// Add the opening apostrophe
			attributeParameterString = [attributeParameterString stringByAppendingString:@"'"];
			
			// Add the attribute name
			attributeParameterString = [attributeParameterString stringByAppendingString:attributeKey];
			
			// Add the closing apostrophe, arrow and opening apostrophe
			attributeParameterString = [attributeParameterString stringByAppendingString:@"'=>'"];
			
			// Add the attribute value
			attributeParameterString = [attributeParameterString stringByAppendingString:[[attributes objectForKey:attributeKey] value]];
			
			// Add the closing apostrophe and comma
			attributeParameterString = [attributeParameterString stringByAppendingString:@"',"];
			
		}
		
		// Remove the last comma
		attributeParameterString = [attributeParameterString substringToIndex:[attributeParameterString length] - 1];
		
		// Add the closing bracket
		attributeParameterString = [attributeParameterString stringByAppendingString:@"}"];
		
	}
	
	// Prepare the query parameter string
	NSMutableArray *queryKeys = [[NSMutableArray alloc] init];
	NSMutableArray *queryValues = [[NSMutableArray alloc] init];
	
	// Fill the parameter string with user if available
	if (userName != nil) {
		[queryKeys addObject:@"user"];
		[queryValues addObject:userName];
	}
	
	// Fill the parameter string with type if available
	if (contextType != nil) {
		[queryKeys addObject:@"type"];
		[queryValues addObject:contextType];
	}
	
	// Fill the parameter string with attributes if available
	if ([attributeKeys count] > 0) {
		[queryKeys addObject:@"attributes"];
		[queryValues addObject:attributeParameterString];
	}
	
	// Create query parameter dictionary
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjects:queryValues forKeys:queryKeys];
	
	// Load contexts from remote
	NSArray *contextResults = [NSMutableArray arrayWithArray:[Context findAllRemoteWithParams:params]];
	
	// Create return dictionary for contexts
	NSMutableDictionary *contextDictionary = [[NSMutableDictionary alloc] init];
	
	// Iterate all context results
	for(Context *context in contextResults) {
		
		// Add context to the return dictionary
		[contextDictionary setObject:context forKey:context.name];
	}
	
	// Return the context dictionary
	return contextDictionary;	
	
}
	
- (BOOL)addContext:(NSString *)contextName withType:(NSString *)contextType withConditions:(NSDictionary *)conditions {

	// not yet implemented!
	
	return NO;
	
}

- (BOOL)addContext:(NSString *)contextName withType:(NSString *)contextType withConditions:(NSDictionary *)conditions forUser:(NSString *)user {

	// not yet implemented!
	
	return NO;

}

- (BOOL)removeContext:(NSString *)contextName {

	// not yet implemented!
	
	return NO;
	
}

- (BOOL)removeContext:(NSString *)contextName forUser:(NSString *)userName {

	// not yet implemented!
	
	return NO;
	
}

- (NSArray *)getContextSources {

	// Return all context source names, sorted alphabetically
	return [self sortDictionaryByKeys:contextSourcePool];
	
}

- (NSArray *)getSourceAttributes:(NSString *)source {

	// Return the source attributes of the requested source
	return [[contextSources objectForKey:source] getAttributes];

}

- (BOOL)contextSourceEnabled:(NSString *)contextSource {

	// Check if context source is in the dictionary
	if ([contextSources objectForKey:contextSource] != nil)

		// Context source is enabled
		return YES;
	else
		// Context source is disabled
		return NO;

}

- (BOOL)enableContextSource:(NSString *)contextSource {
	
	// If context source not already available
	if ([contextSources objectForKey:contextSource] == nil) {
	
		// If new context source is available in the pool
		if ([contextSourcePool objectForKey:contextSource] != nil) {
			
			// If the class with the given name exists
			if (NSClassFromString([contextSourcePool objectForKey:contextSource]) != nil) {

				// Make an object from the given source class
				id sourceObject = [[NSClassFromString([contextSourcePool objectForKey:contextSource]) alloc] init];
				
				// Add the context source object with the given name, its key
				[contextSources setObject:sourceObject forKey:contextSource];
				
				// Release the source object
				[sourceObject release];
				
				// Adding successful
				return YES;
			}
			else
				// Adding failed
				return NO;
		}
		else
			// Adding failed
			return NO;
	}
	else
		// Adding failed
		return NO;

}

- (BOOL)disableContextSource:(NSString *)contextSource {

	// If context source is available
	if ([contextSources objectForKey:contextSource] != nil) {

		// Remove context source with the given name, its key
		[contextSources removeObjectForKey:contextSource];
		
		// Removal successful
		return YES;
	}
	else
		// Removal failed
		return NO;
	
}

- (NSDictionary *)getSourceAttributes {

	// Create a dictionary for the return attributes
	NSMutableDictionary *attributeDictionary = [[NSMutableDictionary alloc] init];
	
	// Get all context sources
	NSArray *contextSourceKeys = [NSArray arrayWithArray:[contextSources allKeys]];

	// Iterate all context sources
	for(NSString *contextSourceKey in contextSourceKeys) {
		ContextSource *contextSource = [contextSources objectForKey:contextSourceKey];
		
		// Get all attributes
		NSDictionary *attributes = [contextSource getAttributeValues];
		NSArray *attributeKeys = [NSArray arrayWithArray:[attributes allKeys]];

		// Iterate all attributes
		for(NSString *attributeKey in attributeKeys) {
			
			// Add all attributes to the return dictionary
			[attributeDictionary setObject:[attributes objectForKey:attributeKey] forKey:attributeKey];
		}
	}

	// Return attribute dictionary
	return attributeDictionary;

}
- (Attribute *)getSourceAttribute:(NSString *)contextSourceType {

	// Delegate call to method "getSourceAttributes"
	return [[self getSourceAttributes] objectForKey:contextSourceType];
	
}

- (BOOL)registerForContextChangeNotifications:(id)observer forContext:(NSString *)contextName {

	// not yet implemented!
	
	return NO;

}

- (BOOL)registerForContextChangeNotifications:(id)observer forContext:(NSString *)contextName forUser:(NSString *)userName {

	// not yet implemented!
	
	return NO;

}

- (BOOL)unregisterFromContextChangeNotifications:(id)observer {

	// not yet implemented!
	
	return NO;

}

- (NSMutableArray*)sortDictionaryByKeys:(NSDictionary*)dict
{
	
	if(!dict)
		return nil;
	NSMutableArray *sortedKeys = [NSMutableArray arrayWithArray: [dict allKeys]];
	if([sortedKeys count] <= 0)
		return nil;
	else if([sortedKeys count] == 1)
		return sortedKeys; // No sort needed
	
	// Perform bubble sort on keys
	int n = [sortedKeys count] -1;
	int i;
	BOOL swapped = YES;
	
	NSString *key1,*key2;
	NSComparisonResult result;
	
	while(swapped)
	{
		swapped = NO;
		for(i=0;i<n;i++)
		{
			key1 = [sortedKeys objectAtIndex: i];
			key2 = [sortedKeys objectAtIndex: i+1];
			
			// Here is a basic NSString comparison
			result = [key1 compare: key2 options: NSCaseInsensitiveSearch];
			if(result == NSOrderedDescending)
			{
				// Retain for good form
				[key1 retain];
				[key2 retain];
				
				// Pop the two keys out of the array
				[sortedKeys removeObjectAtIndex: i]; // Key 1
				[sortedKeys removeObjectAtIndex: i]; // Key 2
		
				// Replace keys
				[sortedKeys insertObject: key1 atIndex: i];
				[sortedKeys insertObject: key2 atIndex: i];
				
				[key1 release];
				[key2 release];
				
				swapped = YES;
			}
		}
	}
	
	return sortedKeys;
}

- (void)dealloc {
	
	[contextSources release];
	[contextSourcePool release];
	[contexts release];
	
	[super dealloc];
	
}

@end
