//
//  SFTongzhiCenter.h
//  CustomNotification
//
//  Created by lurich on 2021/11/2.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFNotification : NSObject
@property (readonly, copy) NSNotificationName name;
@property (nullable, readonly, retain) id object;
@property (nullable, readonly, copy) NSDictionary *userInfo;

- (instancetype)initWithName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

@end

@interface SFTongzhiCenter : NSObject

+ (instancetype)defaultCenter;

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject;

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject;
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable NSNotificationName)aName object:(nullable id)anObject;

@end

NS_ASSUME_NONNULL_END
