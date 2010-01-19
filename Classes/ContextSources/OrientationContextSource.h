//
//  OrientationContextSource.h
//  ContextFramework
//
//  Created by Felix on 05.01.10.
//  Copyright 2010 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context source service for the orientation context.
//	Implements the context source interface.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IContextSource.h"
#import "ContextSource.h"


@interface OrientationContextSource : ContextSource <IContextSource, UIAccelerometerDelegate> {
	
	UIAccelerometer *accelerometer;
	float xValue;
	float yValue;
	float zValue;
	
}

@property (nonatomic, retain) UIAccelerometer *accelerometer;
@property float xValue;
@property float yValue;
@property float zValue;

@end
