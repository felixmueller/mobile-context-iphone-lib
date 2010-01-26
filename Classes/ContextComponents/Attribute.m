//
//  ContextAttribute.m
//  ContextFramework
//
//  Created by Felix on 09.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the attribute class. It stores all information about a context attribute.
//

#import "Attribute.h"


@implementation Attribute

@synthesize	type;
@synthesize	source;
@synthesize	value;
@synthesize	timestamp;
@synthesize	accuracy;
@synthesize	correctness;

NSString * const SOURCE_SENSED	= @"SOURCE_SENSED";
NSString * const SOURCE_USER	= @"SOURCE_USER";
NSString * const SOURCE_DEVICE	= @"SOURCE_DEVICE";
NSString * const SOURCE_REMOTE	= @"SOURCE_REMOTE";

- (void)dealloc {
	
	[type release];
	[source release];
	[value release];
	[timestamp release];
	[accuracy release];
	[correctness release];
	
	[super dealloc];
}

@end
