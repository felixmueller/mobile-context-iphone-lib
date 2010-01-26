//
//  LocationContextSource.m
//  ContextFramework
//
//  Created by Felix on 08.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context source service for the location context.
//	Implements the context source interface.
//

#import "LocationContextSource.h"


@implementation LocationContextSource

@synthesize locationManager;
@synthesize latitude;
@synthesize longitude;
@synthesize altitude;
@synthesize speed;

- (id)init {
	
    self = [super init];
    if (self != nil) {
        
		// Init location manager
		self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self;
		[self.locationManager startUpdatingLocation];
		
		// Init attributes
		NSArray *attributeNames = [NSArray arrayWithObjects:@"latitude", @"longitude", @"altitude", @"speed", nil];
		self.attributes = [NSMutableDictionary dictionaryWithObjects:attributeNames forKeys:attributeNames];
		
    }
    return self;
	
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    NSLog(@"Location: %@", [newLocation description]);

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
	NSLog(@"Error: %@", [error description]);
	
}

- (NSArray *)getAttributes {
	
	return super.getAttributes;
	
}

- (Attribute *)getAttributeValue:(NSString *)attribute {
	
	return [super getAttributeValue:attribute];
	
}

- (NSDictionary *)getAttributeValues {
	
	Attribute *attribute;

	// Gather the location values
	
	latitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
	longitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
	altitude = [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
	speed = [NSString stringWithFormat:@"%f", self.locationManager.location.speed];
	
	// Attribute: latitude
	
	attribute = [[Attribute alloc] init];
	[attribute setTimestamp:[self.locationManager.location timestamp]];
	[attribute setType:@"latitude"];
	[attribute setSource:SOURCE_SENSED];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:(self.locationManager.location.verticalAccuracy / 100)]];
	[attribute setValue:latitude];	
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];
	
	// Attribute: longitude
	
	attribute = [[Attribute alloc] init];
	[attribute setTimestamp:[self.locationManager.location timestamp]];
	[attribute setType:@"longitude"];
	[attribute setSource:SOURCE_SENSED];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:(self.locationManager.location.horizontalAccuracy / 100)]];
	[attribute setValue:longitude];	
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];
	
	// Attribute: altitude
	
	attribute = [[Attribute alloc] init];
	[attribute setTimestamp:[self.locationManager.location timestamp]];
	[attribute setType:@"altitude"];
	[attribute setSource:SOURCE_SENSED];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:nil];
	[attribute setValue:altitude];	
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];
	
	// Attribute: speed
	 
	attribute = [[Attribute alloc] init];
	[attribute setTimestamp:[self.locationManager.location timestamp]];
	[attribute setType:@"speed"];
	[attribute setSource:SOURCE_SENSED];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:nil];
	[attribute setValue:speed];	
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];
	
	return super.getAttributeValues;
	

}	

- (void)dealloc {
	
	[latitude release];
	[longitude release];
	[altitude release];
	[speed release];
	[locationManager release];
	
	[super dealloc];
	
}

@end
