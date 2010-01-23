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
		
		// Init accellerometer
        self.accelerometer = [UIAccelerometer sharedAccelerometer];
		self.accelerometer.updateInterval = .5;
		self.accelerometer.delegate = self;
		
		// Init attributes
		NSArray *attributes = [NSArray arrayWithObjects:@"orientationX", @"orientationY", @"orientationZ", nil];
		self.contextAttributes = [NSMutableDictionary dictionaryWithObjects:attributes forKeys:attributes];
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

- (NSArray *)getContextAttributes {
	
	return super.getContextAttributes;
	
}

- (ContextAttribute *)getContextAttributeValue:(NSString *)attribute {
	
	return [super getContextAttributeValue:attribute];
	
}

- (NSDictionary *)getContextAttributeValues {
	
	ContextAttribute *contextAttribute;
	
	// Attribute: orientationX
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"orientationX"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%f", xValue]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	// Attribute: orientationY
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"orientationY"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%f", yValue]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Attribute: orientationZ
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"orientationZ"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%f", zValue]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	return super.getContextAttributeValues;
	
}

- (void)dealloc {
	
	// Point the event receiver to nil to prevent crashing at release
	self.accelerometer.delegate = nil;

    [accelerometer release];	
	[super dealloc];
	
}

@end