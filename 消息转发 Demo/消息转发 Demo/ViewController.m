//
//  ViewController.m
//  消息转发 Demo
//
//  Created by Lemon on 16/11/3.
//  Copyright © 2016年 Lemon. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "Son.h"
#import "Mother.h"
@interface ViewController ()

@end

@implementation ViewController{
    id  _son;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _son = [Son new];
    
    [_son work];
    
    [_son cook];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIViewController * vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
