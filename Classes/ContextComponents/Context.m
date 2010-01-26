//
//  Context.m
//  ContextFramework
//
//  Created by Felix on 19.01.10.
//  Copyright 2010 Felix Mueller (felixmueller@mac.com). All rights reserved.
//
//	This is the context class. It stores all information about a context.
//

#import "Context.h"


@implementation Context

@synthesize	type;
@synthesize	value;
@synthesize timestamp;


+ (NSArray *)findAllRemoteWithParams:(NSMutableDictionary *)params {
	
    NSString *collectionPath = [self getRemoteCollectionPath];
    NSString *paramsString = @"";
    NSInteger paramCount = 0;
    
	for (id key in params) {
        NSString * escapedUrlParam = (NSString *)
		CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[params objectForKey:key], NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
        if (paramCount == 0)
            paramsString = [paramsString stringByAppendingString:[NSString stringWithFormat:@"?%@=%@", key, escapedUrlParam, nil]];
        else
            paramsString = [paramsString stringByAppendingString:[NSString stringWithFormat:@"&%@=%@", key, escapedUrlParam, nil]];
        paramCount++;
    }
	
    collectionPath = [collectionPath stringByAppendingString:paramsString];
    NSError *aError;
	Response *res = [Connection get:collectionPath];
	if([res isError] && aError)
		aError = res.error;
	
	return [self performSelector:[self getRemoteParseDataMethod] withObject:res.body];
} 

+ (NSArray *)findRemote:(NSString *)elementId withParams:(NSMutableDictionary *)params {
	
    NSString *collectionPath = [self getRemoteCollectionPath];
    NSString *paramsString = @"";
    NSInteger paramCount = 0;
    for (id key in params) {
        NSString * escapedUrlParam = (NSString *)
		CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[params objectForKey:key], NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
        if (paramCount == 0)
            paramsString = [paramsString stringByAppendingString:[NSString stringWithFormat:@"?%@=%@", key, escapedUrlParam, nil]];
        else
            paramsString = [paramsString stringByAppendingString:[NSString stringWithFormat:@"&%@=%@", key, escapedUrlParam, nil]];
        paramCount++;
    }

    collectionPath = [collectionPath stringByAppendingString:paramsString];
    NSError *aError;
	Response *res = [Connection get:[[self getRemoteElementPath:elementId] stringByAppendingString:paramsString] withUser:[[self class] getRemoteUser] andPassword:[[self class]  getRemotePassword]];
	
	if([res isError] && aError)
		aError = res.error;

	return [self performSelector:[self getRemoteParseDataMethod] withObject:res.body];
} 

- (void)dealloc {
	
	[type release];
	[value release];
	[timestamp release];
	
	[super dealloc];
}

@end
