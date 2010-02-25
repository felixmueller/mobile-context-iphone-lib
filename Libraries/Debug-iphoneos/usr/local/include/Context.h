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
#import "Response.h"
#import "Connection.h"


@interface Context : NSObject {
	
	NSString	*type;
	NSString	*name;
	NSDate		*timestamp;
	NSNumber	*accuracy;
	NSNumber	*correctness;
	
}

@property (nonatomic, retain) NSString	*type;
@property (nonatomic, retain) NSString	*name;
@property (nonatomic, retain) NSDate	*timestamp;
@property (nonatomic, retain) NSNumber	*accuracy;
@property (nonatomic, retain) NSNumber	*correctness;

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
