//
//  SFStudent.m
//  CustomNotification
//
//  Created by lurich on 2021/11/2.
//

#import "SFStudent.h"
#import "SFTongzhiCenter.h"

@implementation SFStudent

- (void)addNotification{
    NSLog(@"%@ 添加通知了",[self class]);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemNotification:) name:@"SystemNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemNotification:) name:@"SystemNotification" object:@"object1"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemNotification:) name:@"SystemNotification" object:@"object2"];
    
    [[SFTongzhiCenter defaultCenter] addObserver:self selector:@selector(customNotification:) name:@"CustomNotification" object:nil];
    [[SFTongzhiCenter defaultCenter] addObserver:self selector:@selector(customNotification:) name:@"CustomNotification" object:@"object1"];
    [[SFTongzhiCenter defaultCenter] addObserver:self selector:@selector(customNotification:) name:@"CustomNotification" object:@"object2"];
}
- (void)systemNotification:(NSNotification *)noti{
    NSLog(@"系统通知：%s",__func__);
    NSLog(@"name = %@,userInfo = %@,object = %@",noti.name,noti.userInfo,noti.object);
}

- (void)customNotification:(SFNotification *)noti{
    NSLog(@"自定义通知：%s",__func__);
    NSLog(@"name = %@,userInfo = %@,object = %@",noti.name,noti.userInfo,noti.object);
}

@end
