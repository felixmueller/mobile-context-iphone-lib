//
//  AudioContextSource.h
//  ContextFramework
//
//  Created by Felix on 28.01.10.
//  Copyright 2010 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is a context source service for audio capturing.
//	Implements the context source interface.
//

#import <Foundation/Foundation.h>
#import "IContextSource.h"
#import "ContextSource.h"
#import "SCListener.h"


@interface AudioContextSource : ContextSource <IContextSource> {

	float averageLevel;
	float peakLevel;
	
}

@property float averageLevel;
@property float peakLevel;

@end
