//
//  ContextSource.m
//  ContextFramework
//
//  Created by Felix on 11.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This superclass represents a context source.
//	Specific context source services are derived from this class.
//

#import "ContextSource.h"


@implementation ContextSource

@synthesize contextAttributes;

- (id)init {
	
	// Init the dictionary for context attribute storage
    self = [super init];
    if (self != nil) {
        self.contextAttributes = [[NSMutableDictionary alloc] init];
    }
    return self;
	
}

- (ContextAttribute *)getContextAttributeValue:(NSString *)attribute {

	// Return the context attribute value for the given attribute
	return [contextAttributes objectForKey:attribute];

}

- (NSArray *)getContextAttributes {

	// Return all context attribute names, the keys of the context attribute dictionary
	return [contextAttributes allKeys];

}

- (NSMutableDictionary *)getContextAttributeValues {
	
	// Return all current context attribute objects
	return self.contextAttributes;
	
}

- (void)dealloc {
	
	[contextAttributes release];
	[super dealloc];
}

@end
