//
//  LocationContextSource.h
//  ContextFramework
//
//  Created by Felix on 08.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context source service for the location context.
//	Implements the context source interface.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "IContextSource.h"
#import "ContextSource.h"


@interface LocationContextSource : ContextSource <IContextSource, CLLocationManagerDelegate> {

	CLLocationManager *locationManager;
	NSString *latitude;
	NSString *longitude;
	NSString *altitude;
	NSString *speed;
	
}

@property (nonatomic, retain) CLLocationManager	*locationManager;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *altitude;
@property (nonatomic, retain) NSString *speed;

@end
