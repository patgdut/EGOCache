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

- (NSArray *)arrayForKey:(NSString*)key {
	NSData* data = [self dataForKey:key];
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
	NSArray *result = EGO_RETAIN([unarchiver decodeObjectForKey:@"value"]);
    
	[unarchiver finishDecoding];
    
    EGO_RELEASE_NIL(unarchiver);
    EGO_RELEASE_NIL(data);

	return result;
}

- (void)setArray:(NSArray*)anArray forKey:(NSString*)key {
	[self setData:[self encodeArray:anArray] forKey:key];
}

- (void)setArray:(NSArray*)anArray forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[self setData:[self encodeArray:anArray] forKey:key withTimeoutInterval:timeoutInterval];
}

- (NSData *)encodeArray:(NSArray*)anArray {
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:anArray forKey:@"value"];
	[archiver finishEncoding];
    
    PS_RELEASE_NIL(archiver);
    PS_RETURN_AUTORELEASED(data);
}

#pragma mark -
#pragma mark Dictionary 

- (NSDictionary*)dictionaryForKey:(NSString*)key {
	NSData* data = [self dataForKey:key];
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
	NSDictionary *result = PS_RETAIN([unarchiver decodeObjectForKey:@"value"]);
    
	[unarchiver finishDecoding];
    
    PS_RELEASE_NIL(unarchiver);
    PS_RELEASE_NIL(data);

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
    
    PS_RELEASE_NIL(archiver);
    PS_RETURN_AUTORELEASED(data);
}

@end