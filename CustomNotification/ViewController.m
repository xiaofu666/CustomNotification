//
//  ViewController.m
//  CustomNotification
//
//  Created by lurich on 2021/11/2.
//

#import "ViewController.h"
#import "SFPerson.h"
#import "SFStudent.h"
#import "SFTongzhiCenter.h"

@interface ViewController ()

@property (nonatomic, strong) SFPerson *person;
@property (nonatomic, strong) SFStudent *student;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.person = [SFPerson new];
    [self.person addNotification];
    
    self.student = [SFStudent new];
    [self.student addNotification];
}
//系统通知
- (IBAction)systemNotificationFunc1:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SystemNotification" object:nil];
}
- (IBAction)systemNotificationFunc2:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SystemNotification" object:@"object1"];
}
- (IBAction)systemNotificationFunc3:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SystemNotification" object:@"object2" userInfo:@{@"key":@"value"}];
}
- (IBAction)systemNotificationFunc4:(id)sender {
    NSLog(@"删除系统通知");
//    [[NSNotificationCenter defaultCenter] removeObserver:self.person];
//    [[NSNotificationCenter defaultCenter] removeObserver:self.student];
//    [[NSNotificationCenter defaultCenter] removeObserver:self.person name:@"SystemNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self.student name:@"SystemNotification" object:nil];
}

//自定义通知
- (IBAction)customNotificationFunc1:(id)sender {
    [[SFTongzhiCenter defaultCenter] postNotificationName:@"CustomNotification" object:nil];
}
- (IBAction)customNotificationFunc2:(id)sender {
    [[SFTongzhiCenter defaultCenter] postNotificationName:@"CustomNotification" object:@"object1"];
}
- (IBAction)customNotificationFunc3:(id)sender {
    [[SFTongzhiCenter defaultCenter] postNotificationName:@"CustomNotification" object:@"object2" userInfo:@{@"key":@"value"}];
}
- (IBAction)customNotificationFunc4:(id)sender {
    NSLog(@"删除自定义通知");
//    [[SFTongzhiCenter defaultCenter] removeObserver:self.person];
//    [[SFTongzhiCenter defaultCenter] removeObserver:self.student];
//    [[SFTongzhiCenter defaultCenter] removeObserver:self.person name:@"CustomNotification" object:nil];
    [[SFTongzhiCenter defaultCenter] removeObserver:self.student name:@"CustomNotification" object:nil];
}

@end
