//
//  RemoteHostContextSource.m
//  ContextFramework
//
//  Created by Felix on 26.01.10.
//  Copyright 2010 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is a context source service for the country lookup service "hostip.info".
//	Implements the context source interface.
//

#import "RemoteHostContextSource.h"


@implementation RemoteHostContextSource

@synthesize countryCode;

- (id)init {
	
    self = [super init];
    if (self != nil) {
		
		// Init attributes
		NSArray *attributeNames = [NSArray arrayWithObjects:@"countryCode", nil];
		self.attributes = [NSMutableDictionary dictionaryWithObjects:attributeNames forKeys:attributeNames];

	}
    return self;
	
}

- (NSArray *)getAttributes {
	
	return super.getAttributes;
	
}

- (Attribute *)getAttributeValue:(NSString *)attribute {
	
	return [super getAttributeValue:attribute];
	
}

- (NSDictionary *)getAttributeValues {
	
	Attribute *attribute;
	
	// Gather country code based on current IP from remote
	NSURL *remoteUrl = [NSURL URLWithString:@"http://api.hostip.info/country.php"];
	self.countryCode = [[NSString alloc] initWithContentsOfURL:remoteUrl];
	
	// Attribute: countryCode
	
	attribute = [[Attribute alloc] init];	
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"countryCode"];
	[attribute setSource:SOURCE_REMOTE];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:self.countryCode];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];
	
	return super.getAttributeValues;
	
}

- (void)dealloc {
	
    [countryCode release];
	
	[super dealloc];
	
}

@end
