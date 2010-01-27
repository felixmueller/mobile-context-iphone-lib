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

	NSString *wlanName;
	NSDate *wlanDate;
	NSString *ipAddress;
	
}

@property (nonatomic, retain) NSString *wlanName;
@property (nonatomic, retain) NSDate *wlanDate;
@property (nonatomic, retain) NSString *ipAddress;

@end
