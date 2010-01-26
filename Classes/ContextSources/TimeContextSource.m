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
		NSArray *attributeNames = [NSArray arrayWithObjects:@"date", @"time", @"week", @"weekday", @"timezone", nil];
		self.attributes = [NSMutableDictionary dictionaryWithObjects:attributeNames forKeys:attributeNames];
    }
    return self;
	
}


- (NSArray *)getAttributes {
	
	return super.getAttributes;
	
}

- (Attribute *)getAttributeValue:(NSString *)attribute {
	
	return [super getAttributeValue:attribute];
	
}

- (NSMutableDictionary *)getAttributeValues {

	Attribute *attribute;
	
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

	attribute = [[Attribute alloc] init];	
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"date"];
	[attribute setSource:SOURCE_DEVICE];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:dateString];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];

	// Attribute: time
	
	attribute = [[Attribute alloc] init];	
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"time"];
	[attribute setSource:SOURCE_DEVICE];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:timeString];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];
	
	// Attribute: week
	
	attribute = [[Attribute alloc] init];	
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"week"];
	[attribute setSource:SOURCE_DEVICE];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:[NSString stringWithFormat:@"%d", [week week]]];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];

	// Attribute: weekday
	
	attribute = [[Attribute alloc] init];	
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"weekday"];
	[attribute setSource:SOURCE_DEVICE];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:[NSString stringWithFormat:@"%d", [weekday weekday]]];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];

	// Attribute: timezone
	
	attribute = [[Attribute alloc] init];	
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"timezone"];
	[attribute setSource:SOURCE_DEVICE];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:[timezone name]];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];
	
	return super.getAttributeValues;

}

- (void)dealloc {
	
    [calendar release];
	[super dealloc];
	
}

@end
