//
//  ContextAttribute.m
//  ContextFramework
//
//  Created by Felix on 09.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context attribute class. It stores all information about a context attribute.
//

#import "ContextAttribute.h"


@implementation ContextAttribute

@synthesize	contextType;
@synthesize	contextSource;
@synthesize	contextValue;
@synthesize	contextTimeStamp;
@synthesize	contextAccuracy;
@synthesize	contextCorrectness;

NSString * const SOURCE_SENSED	= @"SOURCE_SENSED";
NSString * const SOURCE_USER	= @"SOURCE_USER";
NSString * const SOURCE_DEVICE	= @"SOURCE_DEVICE";
NSString * const SOURCE_DERIVED	= @"SOURCE_DERIVED";

- (void)encodeWithCoder:(NSCoder*)coder {
	
	[coder encodeObject:contextType			forKey:@"contextType"];
	[coder encodeObject:contextSource		forKey:@"contextSource"];
	[coder encodeObject:contextValue		forKey:@"contextValue"];
	[coder encodeObject:contextTimeStamp	forKey:@"contextTimeStamp"];
	[coder encodeObject:contextAccuracy		forKey:@"contextAccuracy"];
	[coder encodeObject:contextCorrectness	forKey:@"contextCorrectness"];
	
}

- (id)initWithCoder:(NSCoder*)coder {
	
	self = [super init];
	if (!self)
		return nil;
	contextType			= [[coder decodeObjectForKey:@"contextType"] retain];
	contextSource		= [[coder decodeObjectForKey:@"contextSource"] retain];
	contextValue		= [[coder decodeObjectForKey:@"contextValue"] retain];
	contextTimeStamp	= [[coder decodeObjectForKey:@"contextTimeStamp"] retain];
	contextAccuracy		= [[coder decodeObjectForKey:@"contextAccuracy"] retain];
	contextCorrectness	= [[coder decodeObjectForKey:@"contextCorrectness"] retain];
	return self;
	
}

- (void)dealloc {
	
	[contextType release];
	[contextSource release];
	[contextValue release];
	[contextTimeStamp release];
	[contextAccuracy release];
	[contextCorrectness release];
	
	[super dealloc];
}

@end
