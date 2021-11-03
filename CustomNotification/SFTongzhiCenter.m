//
//  SFTongzhiCenter.m
//  CustomNotification
//
//  Created by lurich on 2021/11/2.
//

#import "SFTongzhiCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface SFNotification ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) id object;
@property (nonatomic, copy) NSDictionary *userInfo;

@end

@implementation SFNotification

- (instancetype)initWithName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo{
    SFNotification *notification = [SFNotification new];
    notification.name = name;
    notification.object = object;
    notification.userInfo = userInfo;
    return notification;
}

@end

@interface SFTongzhiCenter ()

@property (nonatomic, strong) NSMutableDictionary *classMap;

@end

@implementation SFTongzhiCenter

+ (instancetype)defaultCenter{
    static dispatch_once_t onceToken;
    static SFTongzhiCenter *tongzhi = nil;
    dispatch_once(&onceToken, ^{
        tongzhi = [SFTongzhiCenter new];
        tongzhi.classMap = [NSMutableDictionary dictionary];
    });
    return tongzhi;
}

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject{
    NSMutableArray *array = self.classMap[aName];
    if (!array) {
        array = [NSMutableArray array];
    }
    [array addObject:@{@"class":observer,@"selector":NSStringFromSelector(aSelector),@"object":anObject?:[NSNull null]}];
    [self.classMap setObject:array forKey:aName];
}

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject{
    [self postNotificationName:aName object:anObject userInfo:nil];
}
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo{
    NSMutableArray *array = self.classMap[aName];
    for (NSDictionary *mapDic in array) {
        //当mapDic中的object与anObject一致时，才调用方法
        if ([mapDic[@"object"] isEqual:anObject] || [mapDic[@"object"] isKindOfClass:[NSNull class]]) {
            //NSInvocation;用来包装方法和对应的对象，它可以存储方法的名称，对应的对象，对应的参数,
            /*
             NSMethodSignature：签名：再创建NSMethodSignature的时候，必须传递一个签名对象，签名对象的作用：用于获取参数的个数和方法的返回值
             */
            //创建签名对象的时候不是使用NSMethodSignature这个类创建，而是方法属于谁就用谁来创建
            NSMethodSignature *signature = [[mapDic[@"class"] class] instanceMethodSignatureForSelector:NSSelectorFromString(mapDic[@"selector"])];
            //1、创建NSInvocation对象
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            invocation.target = mapDic[@"class"];
            //invocation中的方法必须和签名中的方法一致。
            invocation.selector = NSSelectorFromString(mapDic[@"selector"]);
            /*第一个参数：需要给指定方法传递的值
                   第一个参数需要接收一个指针，也就是传递值的时候需要传递地址*/
            //第二个参数：需要给指定方法的第几个参数传值
            //注意：设置参数的索引时不能从0开始，因为0已经被self占用，1已经被_cmd占用
            SFNotification *noti = [[SFNotification alloc] initWithName:aName object:anObject userInfo:aUserInfo];
            [invocation setArgument:&noti atIndex:2];
            //2、调用NSInvocation对象的invoke方法
            //只要调用invocation的invoke方法，就代表需要执行NSInvocation对象中制定对象的指定方法，并且传递指定的参数
            [invocation invoke];
        }
    }
}
- (void)removeObserver:(id)observer{
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
    [self.classMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableArray *tmpArray = [obj mutableCopy];
        for (NSDictionary *mapDic in obj) {
            if ([mapDic[@"class"] isKindOfClass:[observer class]]) {
                [tmpArray removeObject:mapDic];
            }
        }
        [tmpDict setObject:tmpArray forKey:key];
    }];
    self.classMap = tmpDict;
}
- (void)removeObserver:(id)observer name:(nullable NSNotificationName)aName object:(nullable id)anObject{
    NSMutableArray *array = self.classMap[aName];
    NSMutableArray *tmpArray = [array mutableCopy];
    for (NSDictionary *mapDic in array) {
        if ([mapDic[@"class"] isKindOfClass:[observer class]]) {
            if ([mapDic[@"object"] isEqual:anObject] || !anObject) {
                [tmpArray removeObject:mapDic];
            }
        }
    }
    [self.classMap setObject:tmpArray forKey:aName];
}

@end
