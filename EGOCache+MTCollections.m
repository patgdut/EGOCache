//
//  EGOCache+Convenience.m
//
//  Created by Tom Adriaenssen on 25/01/11.
//

#import "EGOCache+MTCollections.h"
#import "EGOCache.h"

@interface EGOCache ()

- (NSData*)encodeDictionary:(NSDictionary*)aDictionary;
- (NSData*)encodeArray:(NSArray*)anArray;

@end

@implementation EGOCache (MTCollections)

#pragma mark -
#pragma mark Array 

- (NSArray*)arrayForKey:(NSString*)key {
	NSData* data = [self dataForKey:key];

	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	NSArray *result = [[unarchiver decodeObjectForKey:@"value"] retain];
	[unarchiver finishDecoding];
	[unarchiver release];
	[data release];

	return result;
}

- (void)setArray:(NSArray*)anArray forKey:(NSString*)key {
	[self setData:[self encodeArray:anArray] forKey:key];
}

- (void)setArray:(NSArray*)anArray forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[self setData:[self encodeArray:anArray] forKey:key withTimeoutInterval:timeoutInterval];
}

- (NSData*)encodeArray:(NSArray*)anArray {
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:anArray forKey:@"value"];
	[archiver finishEncoding];
	[archiver release];

	return [data autorelease];
}

#pragma mark -
#pragma mark Dictionary 

- (NSDictionary*)dictionaryForKey:(NSString*)key {
	NSData* data = [self dataForKey:key];

	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	NSDictionary *result = [[unarchiver decodeObjectForKey:@"value"] retain];
	[unarchiver finishDecoding];
	[unarchiver release];
	[data release];

	return result;
}

- (void)setDictionary:(NSDictionary*)aDictionary forKey:(NSString*)key {
	[self setData:[self encodeDictionary:aDictionary] forKey:key];
}

- (void)setDictionary:(NSDictionary*)aDictionary forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[self setData:[self encodeDictionary:aDictionary] forKey:key withTimeoutInterval:timeoutInterval];
}

- (NSData*)encodeDictionary:(NSDictionary*)aDictionary {
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:aDictionary forKey:@"value"];
	[archiver finishEncoding];
	[archiver release];

	return [data autorelease];
}

@end