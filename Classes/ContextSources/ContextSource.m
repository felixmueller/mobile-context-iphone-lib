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
	
    self = [super init];
    if (self != nil) {
        self.contextAttributes = [[NSMutableDictionary alloc] init];
    }
    return self;
	
}

- (NSMutableDictionary *)gatherContexts {
	
	return self.contextAttributes;
	
}

- (void)dealloc {
	
	[contextAttributes release];
	[super dealloc];
}

@end
