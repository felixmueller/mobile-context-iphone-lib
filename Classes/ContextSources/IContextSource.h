//
//  IContextSource.h
//  ContextFramework
//
//  Created by Felix on 08.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This protocol defines the interface that every context source has to implement.
//

#import "Attribute.h"

@protocol IContextSource <NSObject>

@required

//
// These are the context source API methods that can be called on every context source
//

/*
 * This method requests all attributes the context source can deliver.
 *
 * Parameters:
 *   none
 *
 * Returns:
 *   An NSArray of NSString with the names of the context attributes
 *   nil if no context attribute was found or an error did occur
 *
 */
- (NSArray *)getAttributes;

/*
 * This method requests all current attribute values from the context source.
 *
 * Parameters:
 *   none
 *
 * Returns:
 *   An NSDictionary of Attributes with all current attribute values
 *   nil if no attribute values were found or an error did occur
 *
 */
- (NSMutableDictionary *)getAttributeValues;

/*
 * This method requests a specific current attribute value from the context source.
 *
 * Parameters:
 *   attribute: An NSString containing the name of the requested attribute
 *
 * Returns:
 *   An Attribute with the current context attribute value
 *   nil if no context attribute value was found or an error did occur
 *
 */
- (Attribute *)getAttributeValue:(NSString *)attribute;

@end
