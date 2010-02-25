//
//  ContextAttribute.h
//  ContextFramework
//
//  Created by Felix on 09.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context attribute class. It stores all information about a context attribute.
//

#import <Foundation/Foundation.h>

extern NSString * const SOURCE_SENSED;
extern NSString * const SOURCE_USER;
extern NSString * const SOURCE_DEVICE;
extern NSString * const SOURCE_REMOTE;
extern NSString * const SOURCE_DERIVED;

@interface ContextAttribute : NSObject <NSCoding> {

	NSString	*contextType;
	NSString	*contextSource;
	NSString	*contextValue;
	NSDate		*contextTimeStamp;
	NSNumber	*contextAccuracy;
	NSNumber	*contextCorrectness;
	
}

@property (nonatomic, retain) NSString	*contextType;
@property (nonatomic, retain) NSString	*contextSource;
@property (nonatomic, retain) NSString	*contextValue;
@property (nonatomic, retain) NSDate	*contextTimeStamp;
@property (nonatomic, retain) NSNumber	*contextAccuracy;
@property (nonatomic, retain) NSNumber	*contextCorrectness;

@end
