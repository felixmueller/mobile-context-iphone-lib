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
@synthesize dateString;
@synthesize timeString;
@synthesize week;
@synthesize weekday;
@synthesize timezone;

- (id)init {
	
    self = [super init];
    if (self != nil) {
		
		// Init attributes
		NSArray *attributes = [NSArray arrayWithObjects:@"date", @"time", @"week", @"weekday", @"timezone", nil];
		self.contextAttributes = [NSMutableDictionary dictionaryWithObjects:attributes forKeys:attributes];
    }
    return self;
	
}


- (NSArray *)getContextAttributes {
	
	return super.getContextAttributes;
	
}

- (ContextAttribute *)getContextAttributeValue:(NSString *)attribute {
	
	return [super getContextAttributeValue:attribute];
	
}

- (NSMutableDictionary *)getContextAttributeValues {

	ContextAttribute *contextAttribute;
	
	// Gather, set up and format the time source values
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]  autorelease];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	NSDateFormatter *timeFormatter = [[[NSDateFormatter alloc] init]  autorelease];
	[timeFormatter setDateStyle:NSDateFormatterNoStyle];
	[timeFormatter setTimeStyle:NSDateFormatterMediumStyle];
	calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	date = [NSDate date];
	dateString = [dateFormatter stringFromDate:date];
	timeString = [timeFormatter stringFromDate:date];
	week = [calendar components:NSWeekCalendarUnit fromDate:date];
	weekday = [calendar components:NSWeekdayCalendarUnit fromDate:date];
	timezone = [NSTimeZone systemTimeZone];
	
	// Attribute: date

	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"date"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:dateString];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	// Attribute: time
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"time"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:timeString];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	// Attribute: week
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"week"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%d", [week week]]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	// Attribute: weekday
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"weekday"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[NSString stringWithFormat:@"%d", [weekday weekday]]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];

	// Attribute: timezone
	
	contextAttribute = [[ContextAttribute alloc] init];	
	[contextAttribute setContextTimeStamp:[NSDate date]];
	[contextAttribute setContextType:@"timezone"];
	[contextAttribute setContextSource:SOURCE_DEVICE];
	[contextAttribute setContextCorrectness:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextAccuracy:[NSNumber numberWithDouble:1.0]];
	[contextAttribute setContextValue:[timezone name]];
	[self.contextAttributes setObject:contextAttribute forKey:[contextAttribute contextType]];
	[contextAttribute release];
	
	return super.getContextAttributeValues;

}

- (void)dealloc {
	
    [calendar release];
	[super dealloc];
	
}

@end
