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

	NSDate *date;
	NSCalendar *calendar;
	NSDateComponents *hour;
	NSDateComponents *minute;
	NSDateComponents *second;
	NSDateComponents *year;
	NSDateComponents *month;
	NSDateComponents *day;
	NSDateComponents *week;
	NSDateComponents *weekday;
	NSTimeZone *timezone;
	
}

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSCalendar *calendar;
@property (nonatomic, retain) NSDateComponents *hour;
@property (nonatomic, retain) NSDateComponents *minute;
@property (nonatomic, retain) NSDateComponents *second;
@property (nonatomic, retain) NSDateComponents *year;
@property (nonatomic, retain) NSDateComponents *month;
@property (nonatomic, retain) NSDateComponents *day;
@property (nonatomic, retain) NSDateComponents *week;
@property (nonatomic, retain) NSDateComponents *weekday;
@property (nonatomic, retain) NSTimeZone *timezone;

@end
