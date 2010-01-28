//
//  AudioContextSource.m
//  ContextFramework
//
//  Created by Felix on 28.01.10.
//  Copyright 2010 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is a context source service for audio capturing.
//	Implements the context source interface.
//

#import "AudioContextSource.h"


@implementation AudioContextSource

@synthesize averageLevel;
@synthesize peakLevel;

- (id)init {
	
    self = [super init];
    if (self != nil) {
		
		// Init attributes
		NSArray *attributeNames = [NSArray arrayWithObjects:@"averageLevel", @"peakLevel", nil];
		self.attributes = [NSMutableDictionary dictionaryWithObjects:attributeNames forKeys:attributeNames];
		
		// Start listening.
		[[SCListener sharedListener] listen];
		
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
	
	// Gather the values from the audio listener
	self.averageLevel = [[SCListener sharedListener] averagePower];
	self.peakLevel = [[SCListener sharedListener] peakPower];
	
	// Attribute: averageLevel
	
	attribute = [[Attribute alloc] init];	
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"averageLevel"];
	[attribute setSource:SOURCE_SENSED];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:[NSString stringWithFormat:@"%f", averageLevel]];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];

	// Attribute: peakLevel
	
	attribute = [[Attribute alloc] init];	
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"peakLevel"];
	[attribute setSource:SOURCE_SENSED];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:[NSString stringWithFormat:@"%f", peakLevel]];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];
	
	return super.getAttributeValues;
	
}

- (void)dealloc {
	
	[super dealloc];
	
}

@end
