//
//  EGOCache.h
//  enormego
//
//  Created by Shaun Harrison on 7/4/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>

#if __has_feature(objc_arc)
#define EGO_RETAIN(o) o
#define EGO_AUTORELEASE(o) o
#define EGO_RELEASE(o) o
#define EGO_RELEASE_NIL(x) x = nil

#define EGO_DO_RELEASE(o)
#define __ar_autoreleasing __autoreleasing
#define EGO_RETURN_AUTORELEASED(...) do { \
id __autoreleasing instance = __VA_ARGS__; \
return instance; \
} while (0)
#else
#define EGO_RETAIN(o) [o retain]
#define EGO_AUTORELEASE(o) [o autorelease]
#define EGO_DO_RELEASE(o) [o release]
#define EGO_RELEASE(o) [o release]
#define EGO_RELEASE_NIL(o) [o release], o = nil
#define __ego_autoreleasing
#define EGO_RETURN_AUTORELEASED(...) do { \
return [__VA_ARGS__ autorelease]; \
} while (0)
#endif

@interface EGOCache : NSObject {
@private
	NSMutableDictionary* cacheDictionary;
	NSOperationQueue* diskOperationQueue;
	NSTimeInterval defaultTimeoutInterval;
}

+ (EGOCache*)currentCache;

- (void)clearCache;
- (void)removeCacheForKey:(NSString*)key;

- (BOOL)hasCacheForKey:(NSString*)key;

- (NSData*)dataForKey:(NSString*)key;
- (void)setData:(NSData*)data forKey:(NSString*)key;
- (void)setData:(NSData*)data forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSString*)stringForKey:(NSString*)key;
- (void)setString:(NSString*)aString forKey:(NSString*)key;
- (void)setString:(NSString*)aString forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

#if TARGET_OS_IPHONE
- (UIImage*)imageForKey:(NSString*)key;
- (void)setImage:(UIImage*)anImage forKey:(NSString*)key;
- (void)setImage:(UIImage*)anImage forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;
#else
- (NSImage*)imageForKey:(NSString*)key;
- (void)setImage:(NSImage*)anImage forKey:(NSString*)key;
- (void)setImage:(NSImage*)anImage forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;
#endif

- (NSData*)plistForKey:(NSString*)key;
- (void)setPlist:(id)plistObject forKey:(NSString*)key;
- (void)setPlist:(id)plistObject forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (void)copyFilePath:(NSString*)filePath asKey:(NSString*)key;
- (void)copyFilePath:(NSString*)filePath asKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;	

@property(nonatomic,assign) NSTimeInterval defaultTimeoutInterval; // Default is 1 day
@end