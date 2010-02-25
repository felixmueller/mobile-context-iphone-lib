//
//  TimeContextSource.h
//  ContextFramework
//
//  Created by Felix on 10.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context source service for the time context.
//	Implements the context source interface.
//

#import <Foundation/Foundation.h>
#import "IContextSource.h"
#import "ContextSource.h"


@interface TimeContextSource : ContextSource <IContextSource> {

	NSCalendar *calendar;
	NSDate *date;
	NSString *dateString;
	NSString *timeString;
	NSDateComponents *week;
	NSDateComponents *weekday;
	NSTimeZone *timezone;
	
}

@property (nonatomic, retain) NSCalendar *calendar;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *dateString;
@property (nonatomic, retain) NSString *timeString;
@property (nonatomic, retain) NSDateComponents *week;
@property (nonatomic, retain) NSDateComponents *weekday;
@property (nonatomic, retain) NSTimeZone *timezone;

@end
