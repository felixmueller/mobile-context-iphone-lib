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
#import "Context.h"


@interface ContextService : NSObject {

	/*
	 * This dictionary stores all available context sources with their class names
	 */
	NSDictionary<IContextSource> *contextSourcePool;
	
	/*
	 * This mutable dictionary stores all active context source objects with their names
	 */
	NSMutableDictionary<IContextSource> *contextSources;
	
	NSMutableArray *contexts;
	
}

@property (nonatomic, retain) NSDictionary<IContextSource> *contextSources;
@property (nonatomic, retain) NSDictionary<IContextSource> *contextSourcePool;
@property (nonatomic, retain) NSMutableArray *contexts;

//
// These are the context service API methods that mobile applications can use
//

/*
 * This method requests all existing users from the context model.
 *
 * Parameters:
 *   none
 *
 * Returns:
 *   An NSArray of NSStrings with all user names
 *   nil if no users were found or an error did occur
 *
 */
- (NSArray *)getUsers;

/*
 * This method adds a user to the context model.
 *
 * Parameters:
 *   userName: An NSString containing the user name
 *
 * Returns:
 *   YES if the user was added successfully
 *   NO if the user does already exist or an error did occur
 *
 */
- (BOOL)addUser:(NSString *)userName;

/*
 * This method removes a user from the context model.
 *
 * Parameters:
 *   userName: An NSString containing the user name
 *
 * Returns:
 *   YES if the user was removed successfully
 *   NO if the user was not found an error did occur
 *
 */
- (BOOL)removeUser:(NSString *)userName;

/*
 * This method requests all global contexts from the context model.
 *
 * Parameters:
 *   none
 *
 * Returns:
 *   An NSDictionary of Context with keys = context types and values = Context objects
 *   nil if no contexts were found or an error did occur
 *
 */
- (NSDictionary *)getContexts;

/*
 * This method requests all contexts for a given user from the context model.
 *
 * Parameters:
 *   userName: An NSString containing the user name
 *
 * Returns:
 *   An NSDictionary of Context with keys = context types and values = Context objects
 *   nil if no contexts were found or an error did occur
 *
 */
- (NSDictionary *)getContextsForUser:(NSString *)userName;

/*
 * This method requests all contexts for a given user and a given type from the context model.
 *
 * Parameters:
 *   userName: An NSString containing the user name
 *   contextType: An NSString containing the context type
 *
 * Returns:
 *   An NSDictionary of Context with keys = context types and values = Context objects
 *   nil if no contexts were found or an error did occur
 *
 */
- (NSDictionary *)getContextsForUser:(NSString *)userName withType:(NSString *)contextType;

/*
 * This method adds a global context with a given type and given condidions to the context model.
 *
 * Parameters:
 *   contextName: An NSString containing the context name
 *   contextType: An NSString containing the context type
 *   conditions: An NSDictionary of NSString with keys = subjects and values = objects
 *
 * Returns:
 *   YES if context was successfully added
 *   NO of context exists or an error did occur
 *
 */
- (BOOL)addContext:(NSString *)contextName withType:(NSString *)contextType withConditions:(NSDictionary *)conditions;

/*
 * This method adds a context with a given type and given condidions for a given user to the context model.
 *
 * Parameters:
 *   contextName: An NSString containing the context name
 *   contextType: An NSString containing the context type
 *   conditions: An NSDictionary of NSString with keys = subjects and values = objects
 *   userName: An NSString containing the user name
 *
 * Returns:
 *   YES if context was successfully added
 *   NO of context exists or an error did occur
 *
 */
- (BOOL)addContext:(NSString *)contextName withType:(NSString *)contextType withConditions:(NSDictionary *)conditions forUser:(NSString *)user;

/*
 * This method removes a context with a given type from the context model.
 *
 * Parameters:
 *   contextName: An NSString containing the context name
 *
 * Returns:
 *   YES if the context was removed successful
 *   NO if the context was not found an error did occur
 *
 */
- (BOOL)removeContext:(NSString *)contextName;

/*
 * This method removes a context with a given type for a given user from the context model.
 *
 * Parameters:
 *   contextName: An NSString containing the context name
 *   userName: An NSString containing the user name
 *
 * Returns:
 *   YES if the context was removed successfully
 *   NO if the context was not found an error did occur
 *
 */
- (BOOL)removeContext:(NSString *)contextName forUser:(NSString *)userName;

/*
 * This method requests all context sources currently available in the context service.
 *
 * Parameters:
 *   none
 *
 * Returns:
 *   An NSArray of NSString with all context source names
 *   nil if no context sources were found or an error did occur
 *
 */
- (NSArray *)getContextSources;

/*
 * This method requests all context attributes the context source can deliver.
 *
 * Parameters:
 *   source: An NSString containing the context source name
 *
 * Returns:
 *   An NSArray if NSString with the names of the context source attributes
 *   nil if no context attributes were found or an error did occur
 *
 */
- (NSArray *)getContextSourceAttributes:(NSString *)source;

/*
 * This method checks if a given context source is enabled.
 *
 * Parameters:
 *   contextSource: An NSString containing the name of the context source
 *
 * Returns:
 *   YES if the context source is enabled
 *   NO if the context source is disabled
 *
 */
- (BOOL)contextSourceEnabled:(NSString *)contextSource;

/*
 * This method enables a given context sources.
 *
 * Parameters:
 *   contextSource: An NSString containing the name of the context source
 *
 * Returns:
 *   YES if the context source was enabled successfully
 *   NO if the context source was not found an error did occur
 *
 */
- (BOOL)enableContextSource:(NSString *)contextSource;

/*
 * This method disables a given context sources.
 *
 * Parameters:
 *   contextSource: An NSString containing the name of the context source
 *
 * Returns:
 *   YES if the context source was disenabled successfully
 *   NO if the context source was not found an error did occur
 *
 */
- (BOOL)disableContextSource:(NSString *)contextSource;

/*
 * This method requests all context source attributes currently available by the context service.
 *
 * Parameters:
 *   none
 *
 * Returns:
 *   An NSDictionary of ContextAttribute with keys = source and values = ContextAttribute objects
 *   nil if no context source attributes were found or an error did occur
 *
 */
- (NSDictionary *)getContextSourceAttributes;

/*
 * This method requests a specific context source attribute from the context service.
 *
 * Parameters:
 *   contextSourceType: An NSString containing the context source type
 *
 * Returns:
 *   A ContextAttribute with the current context data gathered by the source
 *   nil if the context source attribute was not found or an error did occur
 *
 */
- (ContextAttribute *)getContextSourceAttribute:(NSString *)contextSourceType;

/*
 * This method registers an object for context change notifications for a given context.
 *
 * Parameters:
 *   observer: An Object registering as an observer
 *   contextName: An NSString containing the context name
 *
 * Returns:
 *   YES if the registration was successful
 *   NO if an error did occur
 *
 */
- (BOOL)registerForContextChangeNotifications:(id)observer forContext:(NSString *)contextName;

/*
 * This method registers an object for context change notifications for a given context and a given user.
 *
 * Parameters:
 *   observer: An Object registering as an observer
 *   contextName: An NSString containing the context name
 *   userName: An NSString containing the user name
 *
 * Returns:
 *   YES if the registration was successful
 *   NO if an error did occur
 *
 */
- (BOOL)registerForContextChangeNotifications:(id)observer forContext:(NSString *)contextName forUser:(NSString *)userName;

/*
 * This method unregisters an object from context change notifications.
 *
 * Parameters:
 *   observer: An Object registering as an observer
 *   contextName: An NSString containing the context name
 *   userName: An NSString containing the user name
 *
 * Returns:
 *   YES if the unregistration was successful
 *   NO if an error did occur
 *
 */
- (BOOL)unregisterFromContextChangeNotifications:(id)observer;

@end
