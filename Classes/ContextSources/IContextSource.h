//
//  IContextSource.h
//  ContextFramework
//
//  Created by Felix on 08.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This protocol defines the interface that every context source has to implement.
//

#import "ContextAttribute.h"

@protocol IContextSource <NSObject>

//
// These are the context source API methods that can be called on every context source
//

@required

/*
 * This method requests a specific current context attribute value from the context source.
 *
 * Parameters:
 *   attribute: An NSString containing the name of the requested context attribute
 *
 * Returns:
 *   A ContextAttribute with the current context attribute value
 *   nil if no context attribute value was found or an error did occur
 *
 */
- (ContextAttribute *)getContextAttributeValue:(NSString *)attribute;

/*
 * This method requests all context attributes the context source can deliver.
 *
 * Parameters:
 *   none
 *
 * Returns:
 *   An NSArray if NSString with the names of the context attributes
 *   nil if no context attribute was found or an error did occur
 *
 */
- (NSArray *)getContextAttributes;

/*
 * This method requests all current context attribute values from the context source.
 *
 * Parameters:
 *   none
 *
 * Returns:
 *   An NSDictionary of ContextAttributes with all current context attribute values
 *   nil if no context attribute values were found or an error did occur
 *
 */
- (NSMutableDictionary *)getContextAttributeValues;

@end
