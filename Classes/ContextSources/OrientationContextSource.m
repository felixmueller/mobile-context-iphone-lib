//
//  OrientationContextSource.m
//  ContextFramework
//
//  Created by Felix on 05.01.10.
//  Copyright 2010 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context source service for the orientation context.
//	Implements the context source interface.
//

#import "OrientationContextSource.h"


@implementation OrientationContextSource

@synthesize accelerometer;
@synthesize xValue;
@synthesize yValue;
@synthesize zValue;

- (id)init {
	
    self = [super init];
    if (self != nil) {
        self.accelerometer = [UIAccelerometer sharedAccelerometer];
		self.accelerometer.updateInterval = .5;
		self.accelerometer.delegate = self;
    }
    return self;
	
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {

	NSLog(@"Orientation X: %@", [NSString stringWithFormat:@"%f", acceleration.x]);
	NSLog(@"Orientation Y: %@", [NSString stringWithFormat:@"%f", acceleration.y]);
	NSLog(@"Orientation Z: %@", [NSString stringWithFormat:@"%f", acceleration.z]);
	
	xValue = acceleration.x;
	yValue = acceleration.y;
	zValue = acceleration.z;
	
}

- (NSDictionary *)gatherContexts {
	
	NSLog(@"OrientationContextServer::gatherContexts called");
	
	ContextAttribute *contextAttribute;
	
	// Context:Orientation:DirectionX
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Orientation:DirectionX"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%f", xValue]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	// Context:Orientation:DirectionY
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Orientation:DirectionY"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%f", yValue]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Context:Orientation:DirectionZ
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Orientation:DirectionZ"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%f", zValue]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	return super.gatherContexts;
	
}

- (void)dealloc {
	
	// Point the event receiver to nil to prevent crashing at release
	self.accelerometer.delegate = nil;

    [accelerometer release];	
	[super dealloc];
	
}

@end