//
//  NetworkContextSource.m
//  ContextFramework
//
//  Created by Felix on 26.01.10.
//  Copyright 2010 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context source service for the network context.
//	Implements the context source interface.
//

#import "NetworkContextSource.h"
#include <ifaddrs.h>
#include <arpa/inet.h>


@implementation NetworkContextSource

@synthesize wifiName;
@synthesize wifiDate;
@synthesize ipAddress;

- (id)init {
	
    self = [super init];
    if (self != nil) {
		
		// Init attributes
		NSArray *attributeNames = [NSArray arrayWithObjects:@"wifiName", @"ipAddress", nil];
		self.attributes = [NSMutableDictionary dictionaryWithObjects:attributeNames forKeys:attributeNames];
		
		// Init values
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
		self.wifiDate = [dateFormatter dateFromString:@"1900-01-01 00:00:00"];
		self.wifiName = @"unknown";
		self.ipAddress = @"unknown";
	
	}
    return self;
	
}

- (NSArray *)getAttributes {
	
	return super.getAttributes;
	
}

- (Attribute *)getAttributeValue:(NSString *)attribute {
	
	return [super getAttributeValue:attribute];
	
}

- (NSDictionary *)getAttributeValues {
	
	Attribute *attribute;
	
	// Access the network infos from the device preferences file
	NSString *networkConfigurationPath = @"/Library/Preferences/SystemConfiguration/com.apple.wifi.plist";
	NSDictionary *networkConfigurationDictionary = [NSDictionary dictionaryWithContentsOfFile:networkConfigurationPath];

	// If network dictionary was created
 	if(networkConfigurationDictionary) {
	
		// Search for known networks
		NSArray *knownNetworks = [networkConfigurationDictionary valueForKey:@"List of known networks"];

		// If known networks were found
		if(knownNetworks) {
		
			// Iterate all known networks
			for(NSDictionary *knownNetwork in knownNetworks) {
		
				// Collect known network information
				NSString *networkName = [knownNetwork valueForKey:@"SSID_STR"];
				NSDate *networkJoined = [knownNetwork valueForKey:@"lastJoined"];
				NSDate *networkAutoJoined = [knownNetwork valueForKey:@"lastAutoJoined"];
				NSDate *networkDate = networkAutoJoined ? networkAutoJoined : networkJoined;
			
				// Save the network name and date if more recent than the old
				if ([self.wifiDate compare:networkDate] == NSOrderedAscending) {
					self.wifiName = networkName;
					self.wifiDate = networkDate;
				}
				
			}
				
		}
		
	}
	
	// Gather the local IP address from the network device
	struct ifaddrs *interfaces = NULL;
	struct ifaddrs *temp_addr = NULL;
	int success = 0;
	
	// Retrieve the current interfaces, returns 0 on success
	success = getifaddrs(&interfaces);
	if (success == 0) {
		
		// Loop through linked list of interfaces
		temp_addr = interfaces;
		while(temp_addr != NULL) {
			
			if(temp_addr->ifa_addr->sa_family == AF_INET)
			{
				// Check if interface is "en0" which is the WiFi connection on the iPhone
				if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
					
					// Get NSString from C String
					self.ipAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
					
				}
				
			}
			
			temp_addr = temp_addr->ifa_next;			
		}
		
	}
	
	// Free memory
	freeifaddrs(interfaces);
	
	// Attribute: wifiName
	
	attribute = [[Attribute alloc] init];	
	[attribute setTimestamp:self.wifiDate];
	[attribute setType:@"wifiName"];
	[attribute setSource:SOURCE_DEVICE];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:self.wifiName];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];

	// Attribute: ipAddress
	
	attribute = [[Attribute alloc] init];	
	[attribute setTimestamp:[NSDate date]];
	[attribute setType:@"ipAddress"];
	[attribute setSource:SOURCE_DEVICE];
	[attribute setCorrectness:[NSNumber numberWithDouble:1.0]];
	[attribute setAccuracy:[NSNumber numberWithDouble:1.0]];
	[attribute setValue:self.ipAddress];
	[self.attributes setObject:attribute forKey:[attribute type]];
	[attribute release];
	
	return super.getAttributeValues;
	
}

- (void)dealloc {
	
    [wifiName release];
	[wifiDate release];
	[ipAddress release];
	
	[super dealloc];
	
}

@end
