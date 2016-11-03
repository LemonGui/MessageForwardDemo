//
//  SecondViewController.m
//  消息转发 Demo
//
//  Created by Lemon on 16/11/3.
//  Copyright © 2016年 Lemon. All rights reserved.
//

#import "SecondViewController.h"
#import "WeakProxy.h"
@interface SecondViewController ()
@property (strong,nonatomic)NSTimer * timer;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    //向WeakProxy 发送 timerInvoked: 消息， WeakProxy 内部将该消息转发给自己的target(weak),也就是这里的self,破掉循环
    self.timer = [NSTimer timerWithTimeInterval:1
                                         target:[WeakProxy proxyWithTarget:self] //利用消息转发破循环引用
                                       selector:@selector(timerInvoked:)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerInvoked:(NSTimer *)timer{
    NSLog(@"~~~~1~~~~");
}

-(void)dealloc{
    [self.timer invalidate];
    NSLog(@"-------------- dealloc ---------------");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
