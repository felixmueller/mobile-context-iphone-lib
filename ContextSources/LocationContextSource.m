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
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self;
		[self.locationManager startUpdatingLocation];
    }
    return self;
	
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    NSLog(@"Location: %@", [newLocation description]);

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	
	NSLog(@"Error: %@", [error description]);
	
}

- (NSDictionary *)gatherContexts {
	
	NSLog(@"LocationContextServer::gatherContexts called");
	
	ContextAttribute *contextAttribute;

	// Gather the location values
	
	latitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
	longitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
	altitude = [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
	speed = [NSString stringWithFormat:@"%f", self.locationManager.location.speed];
	
	// Context:Location:Position:Latitude
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[self.locationManager.location timestamp]];
	[contextAttribute setContextType:@"Context:Location:Position:Latitude"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:(self.locationManager.location.verticalAccuracy / 100)]];
	[contextAttribute setContextValue:latitude];	
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Context:Location:Position:Longitude
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[self.locationManager.location timestamp]];
	[contextAttribute setContextType:@"Context:Location:Position:Longitude"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:(self.locationManager.location.horizontalAccuracy / 100)]];
	[contextAttribute setContextValue:longitude];	
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Context:Location:Position:Altitude
	
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[self.locationManager.location timestamp]];
	[contextAttribute setContextType:@"Context:Location:Position:Altitude"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:nil];
	[contextAttribute setContextValue:altitude];	
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Context:Location:Speed
	 
	contextAttribute = [[ContextAttribute alloc] init];
	[contextAttribute setContextTimeStamp:[self.locationManager.location timestamp]];
	[contextAttribute setContextType:@"Context:Location:Position:Speed"];
	[contextAttribute setContextSource:SOURCE_SENSED];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:nil];
	[contextAttribute setContextValue:speed];	
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	return super.gatherContexts;
	
}

- (void)dealloc {
	
    [locationManager release];
	[latitude release];
	[longitude release];
	[altitude release];
	[speed release];
    
	[super dealloc];
	
}

@end
