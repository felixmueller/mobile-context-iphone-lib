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
		NSArray *attributes = [NSArray arrayWithObjects:@"latitude", @"longitude", @"altitude", @"speed", nil];
		self.contextAttributes = [NSMutableDictionary dictionaryWithObjects:attributes forKeys:attributes];
		
    }
    return self;
	
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    NSLog(@"Location: %@", [newLocation description]);

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
	NSLog(@"Error: %@", [error description]);
	
}

- (NSArray *)getContextAttributes {
	
	return super.getContextAttributes;
	
}

- (ContextAttribute *)getContextAttributeValue:(NSString *)attribute {
	
	return [super getContextAttributeValue:attribute];
	
}

- (NSDictionary *)getContextAttributeValues {
	
	ContextAttribute *contextAttribute;

	// Gather the location values
	
	latitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
	longitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
	altitude = [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
	speed = [NSString stringWithFormat:@"%f", self.locationManager.location.speed];
	
	// Attribute: latitude
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[self.locationManager.location timestamp]];
	[contextAttribute setContextType:@"latitude"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:(self.locationManager.location.verticalAccuracy / 100)]];
	[contextAttribute setContextValue:latitude];	
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Attribute: longitude
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[self.locationManager.location timestamp]];
	[contextAttribute setContextType:@"longitude"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:(self.locationManager.location.horizontalAccuracy / 100)]];
	[contextAttribute setContextValue:longitude];	
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Attribute: altitude
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[self.locationManager.location timestamp]];
	[contextAttribute setContextType:@"altitude"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:nil];
	[contextAttribute setContextValue:altitude];	
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Attribute: speed
	 
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[self.locationManager.location timestamp]];
	[contextAttribute setContextType:@"speed"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:nil];
	[contextAttribute setContextValue:speed];	
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	return super.getContextAttributeValues;
	

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
