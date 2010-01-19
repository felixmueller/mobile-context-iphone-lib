//
//  ContextService.m
//  ContextFramework
//
//  Created by Felix on 11.12.09.
//  Copyright 2009 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context service class, the main class of the context framework.
//

#import "ContextService.h"


@implementation ContextService

@synthesize contextSources;

- (id)init {
	
    self = [super init];
    if (self != nil) {
		id<IContextSource> locationContextSource = [[LocationContextSource alloc] init];
		id<IContextSource> timeContextSource = [[TimeContextSource alloc] init];
		id<IContextSource> orientationContextSource = [[OrientationContextSource alloc] init];
		NSArray *contextSourceKeys = [NSArray arrayWithObjects:	@"Context:Location",
																@"Context:Time",
																@"Context:Orientation", nil];
		NSArray *contextSourceObjects = [NSArray arrayWithObjects:	locationContextSource,
																	timeContextSource,
																	orientationContextSource, nil];
		self.contextSources = [NSDictionary dictionaryWithObjects:contextSourceObjects forKeys:contextSourceKeys];
		[locationContextSource release];
		[timeContextSource release];
		[orientationContextSource release];
    }
    return self;
	
}

- (NSDictionary *)getAllContexts {

	return nil;

}

- (NSString *)getContext:(NSString *)contextType {

	return nil;

}

- (NSDictionary *)getAllContextSources {
	
	NSArray *contextSourceKeys = [NSArray arrayWithArray:[contextSources allKeys]];
	NSMutableDictionary *contextDictionary = [[NSMutableDictionary alloc] init];
	for(NSString *contextSourceKey in contextSourceKeys) {
		ContextSource *contextSource = [contextSources objectForKey:contextSourceKey];
		NSDictionary *contexts = [contextSource gatherContexts];
		NSArray *contextKeys = [NSArray arrayWithArray:[contexts allKeys]];
		for(NSString *contextKey in contextKeys) {
			[contextDictionary setObject:[contexts objectForKey:contextKey] forKey:contextKey];
		}
	}
	
	return contextDictionary;
	
}

- (NSString *)getContextSource:(NSString *)contextSourceType {

	return nil;

}

- (void)dealloc {
	
	[contextSources release];
	[super dealloc];
	
}

@end
