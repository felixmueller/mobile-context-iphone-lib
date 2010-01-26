//
//  ContextSource.m
//  ContextFramework
//
//  Created by Felix on 11.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This superclass represents a context source.
//	Specific context sources are derived from this class.
//

#import "ContextSource.h"


@implementation ContextSource

@synthesize attributes;

- (id)init {
	
	// Init the dictionary for attribute storage
    self = [super init];
    if (self != nil) {
        self.attributes = [[NSMutableDictionary alloc] init];
    }
    return self;
	
}

- (NSArray *)getAttributes {

	// Return all attribute names, the keys of the attribute dictionary
	return [attributes allKeys];

}

- (NSMutableDictionary *)getAttributeValues {
	
	// Return all current attribute objects
	return self.attributes;
	
}

- (Attribute *)getAttributeValue:(NSString *)attribute {
	
	// Return the attribute value for the given attribute
	return [attributes objectForKey:attribute];
	
}

- (void)dealloc {
	
	[attributes release];
	
	[super dealloc];
}

@end
