//
//  TimeContextSource.m
//  ContextFramework
//
//  Created by Felix on 10.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context source service for the time context.
//	Implements the context source interface.
//

#import "TimeContextSource.h"


@implementation TimeContextSource

@synthesize calendar;
@synthesize date;
@synthesize hour;
@synthesize minute;
@synthesize second;
@synthesize year;
@synthesize month;
@synthesize day;
@synthesize week;
@synthesize weekday;
@synthesize timezone;

- (NSMutableDictionary *)gatherContexts {
	
	NSLog(@"TimeContextServer::gatherContexts called");

	ContextAttribute *contextAttribute;
	
	// Gather the time and date values
	
	calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	date = [NSDate date];
	hour = [calendar components:NSHourCalendarUnit fromDate:date];
	minute = [calendar components:NSMinuteCalendarUnit fromDate:date];
	second = [calendar components:NSSecondCalendarUnit fromDate:date];
	year = [calendar components:NSYearCalendarUnit fromDate:date];
	month = [calendar components:NSMonthCalendarUnit fromDate:date];
	day = [calendar components:NSDayCalendarUnit fromDate:date];
	week = [calendar components:NSWeekCalendarUnit fromDate:date];
	weekday = [calendar components:NSWeekdayCalendarUnit fromDate:date];
	timezone = [NSTimeZone systemTimeZone];
	
	// Context:Time:Hour
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Time:Hour"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%d", [hour hour]]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	// Context:Time:Minute
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Time:Minute"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%d", [minute minute]]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	// Context:Time:Second
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Time:Second"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%d", [second second]]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Context:Time:Year
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Time:Year"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%d", [year year]]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Context:Time:Month
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Time:Month"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%d", [month month]]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	// Context:Time:Day
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Time:Day"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%d", [day day]]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	// Context:Time:Week
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Time:Week"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%d", [week week]]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	// Context:Time:Weekday
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Time:Weekday"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%d", [weekday weekday]]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Context:Time:Timezone
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"Context:Time:Timezone"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[timezone name]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	return super.gatherContexts;

}

- (void)dealloc {
	
    [calendar release];
    [date release];
	[hour release];
	[minute release];
	[second release];
	[year release];
	[month release];
	[day release];
	[week release];
	[weekday release];
	[timezone release];
	
	[super dealloc];
	
}

@end
