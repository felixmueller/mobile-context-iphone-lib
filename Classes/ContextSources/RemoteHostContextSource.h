//
//  RemoteHostContextSource.h
//  ContextFramework
//
//  Created by Felix on 26.01.10.
//  Copyright 2010 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is a context source service for the country lookup service "hostip.info".
//	Implements the context source interface.
//

#import <Foundation/Foundation.h>
#import "IContextSource.h"
#import "ContextSource.h"


@interface RemoteHostContextSource : ContextSource <IContextSource> {

	NSString *countryCode;
	
}

@property (nonatomic, retain) NSString *countryCode;

@end
