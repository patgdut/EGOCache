//
//  EGOCache+Convenience.m
//
//  Created by Tom Adriaenssen on 25/01/11.
//

#import <Foundation/Foundation.h>
#import "EGOCache.h"

@interface EGOCache (MTCollections) 

- (NSArray*)arrayForKey:(NSString*)key NS_RETURNS_RETAINED;
- (void)setArray:(NSArray*)anArray forKey:(NSString*)key;
- (void)setArray:(NSArray*)anArray forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSDictionary*)dictionaryForKey:(NSString*)key NS_RETURNS_RETAINED;
- (void)setDictionary:(NSDictionary*)aDictionary forKey:(NSString*)key;
- (void)setDictionary:(NSDictionary*)aDictionary forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

@end