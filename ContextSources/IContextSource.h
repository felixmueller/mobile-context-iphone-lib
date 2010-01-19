//
//  IContextSource.h
//  ContextFramework
//
//  Created by Felix on 08.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This protocol defines the interface that every context source service has to implement.
//

#import "ContextAttribute.h"

@protocol IContextSource <NSObject>

@required

- (NSMutableDictionary *)gatherContexts;

@end
