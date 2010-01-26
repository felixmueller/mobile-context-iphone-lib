//
//  NetworkContextSource.h
//  ContextFramework
//
//  Created by Felix on 26.01.10.
//  Copyright 2010 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context source service for the network context.
//	Implements the context source interface.
//

#import <Foundation/Foundation.h>
#import "IContextSource.h"
#import "ContextSource.h"


@interface NetworkContextSource : ContextSource <IContextSource> {

	NSString *wifiName;
	NSDate *wifiDate;
	NSString *ipAddress;
	
}

@property (nonatomic, retain) NSString *wifiName;
@property (nonatomic, retain) NSDate *wifiDate;
@property (nonatomic, retain) NSString *ipAddress;

@end
