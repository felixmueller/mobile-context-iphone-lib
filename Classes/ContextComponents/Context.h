//
//  Context.h
//  ContextFramework
//
//  Created by Felix on 19.01.10.
//  Copyright 2010 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context class. It stores all information about a context.
//

#import "ObjectiveResource.h"


@interface Context : NSObject {
	
	NSString	*type;
	NSString	*value;
	NSDate		*timestamp;
	
}

@property (nonatomic, retain) NSString	*type;
@property (nonatomic, retain) NSString	*value;
@property (nonatomic, retain) NSDate	*timestamp;

/*
 * This class method extends ObjectiveResouce by finding all remote resources by adding query parameters.
 *
 * Parameters:
 *   params: NSMutableDictionary with query parameters
 *
 * Returns:
 *   An NSArray of serialized objects
 *
 */
+ (NSArray *)findAllRemoteWithParams:(NSMutableDictionary *)params;

/*
 * This class method extends ObjectiveResouce by finding a specific remote resource by adding query parameters.
 *
 * Parameters:
 *   elementId: NSString containing the id of the remote resource
 *   params: NSMutableDictionary with query parameters
 *
 * Returns:
 *   An NSArray of serialized objects
 *
 */
+ (NSArray *)findRemote:(NSString *)elementId withParams:(NSMutableDictionary *)params;

@end
