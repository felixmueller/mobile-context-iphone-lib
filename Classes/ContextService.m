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
		NSArray *contextSourceNames = [NSArray arrayWithObjects:@"Source:Location", @"Source:Time", @"Source:Orientation", @"Source:Network", @"Source:Device", @"Source:Weather", @"Source:User", nil];
		
		// Classes of all context sourves
		NSArray *contextSourceClasses = [NSArray arrayWithObjects: @"LocationContextSource", @"TimeContextSource", @"OrientationContextSource", @"NetworkContextSource", @"DeviceContextSourve", @"WeatherContextServer", @"UserContextSource", nil];
		
		// Create a pool dictionary of all available context sources
		self.contextSourcePool = [NSDictionary dictionaryWithObjects:contextSourceClasses forKeys:contextSourceNames];
		
		// Create a dictionary of all active context sources
		self.contextSources = [[NSMutableDictionary alloc] init];
				
		// Configure ObjectiveResource
		[ObjectiveResourceConfig setSite:@"http://contextserver.felixmueller.name/"];
		[ObjectiveResourceConfig setUser:@"none"];
		[ObjectiveResourceConfig setPassword:@"none"];
		
		// Use JSON
		//[ObjectiveResourceConfig setResponseType:JSONResponse];
		
		// Use XML
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

	// not yet implemented!
	
	return nil;
}

- (NSDictionary *)getContextsForUser:(NSString *)userName {

	// Create query parameter dictionary
	NSArray *queryKeys = [NSArray arrayWithObjects:@"user", nil];
	NSArray *queryObjects = [NSArray arrayWithObjects:userName, nil];
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjects:queryObjects forKeys:queryKeys];
	
	// Load contexts from remote
	NSArray *contextResults = [NSMutableArray arrayWithArray:[Context findAllRemoteWithParams:params]];
	
	// Create return dictionary for contexts
	NSMutableDictionary *contextDictionary = [[NSMutableDictionary alloc] init];
	
	// Iterate all context results
	for(Context *context in contextResults) {
		
		// Add context to the return dictionary
		[contextDictionary setObject:context forKey:context.value];
	}
	
	// Return the context dictionary
	return contextDictionary;
	
}

- (NSDictionary *)getContextsForUser:(NSString *)userName withType:(NSString *)contextType {

	// not yet implemented!
	
	return nil;
	
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

	// Return all context source names, the keys of the context source dictionary
	return [contextSourcePool allKeys];
	
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

- (NSDictionary *)getContextSourceAttributes {

	// Create a dictionary for the return attributes
	NSMutableDictionary *contextAttributeDictionary = [[NSMutableDictionary alloc] init];
	
	// Get all context sources
	NSArray *contextSourceKeys = [NSArray arrayWithArray:[contextSources allKeys]];

	// Iterate all context sources
	for(NSString *contextSourceKey in contextSourceKeys) {
		ContextSource *contextSource = [contextSources objectForKey:contextSourceKey];
		
		// Get all context attributes
		NSDictionary *contextAttributes = [contextSource gatherContexts];
		NSArray *contextAttributeKeys = [NSArray arrayWithArray:[contextAttributes allKeys]];

		// Iterate all context attributes
		for(NSString *contextAttributeKey in contextAttributeKeys) {
			
			// Add all context attributes to the return dictionary
			[contextAttributeDictionary setObject:[contextAttributes objectForKey:contextAttributeKey] forKey:contextAttributeKey];
		}
	}
	
	// Return attribute dictionary
	return contextAttributeDictionary;

}
- (ContextAttribute *)getContextSourceAttribute:(NSString *)contextSourceType {

	// not yet implemented!
	
	return nil;
	
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

- (void)dealloc {
	
	[contextSources release];
	[contextSourcePool release];
	[contexts release];
	
	[super dealloc];
	
}

@end
