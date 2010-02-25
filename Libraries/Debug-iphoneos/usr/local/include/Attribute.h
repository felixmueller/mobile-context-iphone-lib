//
//  ContextAttribute.h
//  ContextFramework
//
//  Created by Felix on 09.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the attribute class. It stores all information about a context attribute.
//

#import <Foundation/Foundation.h>

extern NSString * const SOURCE_SENSED;
extern NSString * const SOURCE_USER;
extern NSString * const SOURCE_DEVICE;
extern NSString * const SOURCE_REMOTE;

@interface Attribute : NSObject {

	NSString	*type;
	NSString	*source;
	NSString	*value;
	NSDate		*timestamp;
	NSNumber	*accuracy;
	NSNumber	*correctness;
	
}

@property (nonatomic, retain) NSString	*type;
@property (nonatomic, retain) NSString	*source;
@property (nonatomic, retain) NSString	*value;
@property (nonatomic, retain) NSDate	*timestamp;
@property (nonatomic, retain) NSNumber	*accuracy;
@property (nonatomic, retain) NSNumber	*correctness;

@end
