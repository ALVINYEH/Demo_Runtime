//
//  ViewController.m
//  Demo_Runtime
//
//  Created by game-netease-chuyou on 2018/6/5.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Limit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //数组越界测试
    //正常
    NSArray *array = @[@0,@1,@2,@3];
    [array objectAtIndex:3];
    //崩溃
    [array objectAtIndex:4];
    
    [self setSubViews];
}


- (void)setSubViews
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setTitle:@"btnTest" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.acceptEventInterval = 3 ;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnAction
{
    NSLog(@"btnAction is executed");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
