//
//  ContextService.h
//  ContextFramework
//
//  Created by Felix on 11.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context service class, the main class of the context framework.
//

#import <Foundation/Foundation.h>
#import "IContextSource.h"
#import "LocationContextSource.h"
#import "TimeContextSource.h"
#import "OrientationContextSource.h"


@interface ContextService : NSObject {

	NSDictionary<IContextSource> *contextSources;
	
}

@property (nonatomic, retain) NSDictionary<IContextSource> *contextSources;

//
// These are the API methods that mobile applications can use
//

// Get a dictionary with all contexts available
- (NSDictionary *)getAllContexts;

// Get a specific context
- (NSString *)getContext:(NSString *)contextType;

// Get a dictionary with all contexts source attributes available
- (NSDictionary *)getAllContextSources;

// Get a specific context source attribute
- (NSString *)getContextSource:(NSString *)contextSourceType;

//TODO: register context for notification

@end
