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
		NSArray *attributeNames = [NSArray arrayWithObjects:@"orientationX", @"orientationY", @"orientationZ", nil];
		self.attributes = [NSMutableDictionary dictionaryWithObjects:attributeNames forKeys:attributeNames];
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

- (NSArray *)getAttributes {
	
	return super.getAttributes;
	
}

- (Attribute *)getAttributeValue:(NSString *)attribute {
	
	return [super getAttributeValue:attribute];
	
}

- (NSDictionary *)getAttributeValues {
	
	Attribute *attribute;
	
	// Attribute: orientationX
	
	attribute = [[Attribute alloc] init];
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"orientationX"];
	[attribute setSource:SOURCE_SENSED];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:[NSString stringWithFormat:@"%f", xValue]];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];

	// Attribute: orientationY
	
	attribute = [[Attribute alloc] init];
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"orientationY"];
	[attribute setSource:SOURCE_SENSED];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:[NSString stringWithFormat:@"%f", yValue]];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];
	
	// Attribute: orientationZ
	
	attribute = [[Attribute alloc] init];
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"orientationZ"];
	[attribute setSource:SOURCE_SENSED];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:[NSString stringWithFormat:@"%f", zValue]];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];

	return super.getAttributeValues;
	
}

- (void)dealloc {
	
	// Point the event receiver to nil to prevent crashing at release
	self.accelerometer.delegate = nil;

    [accelerometer release];	
	[super dealloc];
	
}

@end