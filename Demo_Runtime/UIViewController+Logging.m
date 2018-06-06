//
//  UIViewController+Logging.m
//  Demo_Runtime
//
//  Created by game-netease-chuyou on 2018/6/5.
//  Copyright © 2018年 chuyou. All rights reserved.
//

@import UIKit;
#import "UIViewController+Logging.h"
#import <objc/runtime.h>


@implementation UIViewController (Logging)

+ (void)load
{
    swizzleMethod([self class], @selector(viewDidAppear:), @selector(swizzled_viewDidAppear:));
}


- (void) swizzled_viewDidAppear:(BOOL)animated
{
    //调用原始方法
    [self swizzled_viewDidAppear:animated];
    
    //打印
    NSLog(@"Print Count = %@",NSStringFromClass([self class]));
}

void swizzleMethod(Class class,SEL originalSelector,SEL swizzledSelector)
{
    //方法在类中可能没有，但是在父类中定义了
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMehtod = class_getInstanceMethod(class, swizzledSelector);
    
    //如果原始方法已经存在了，class_addMethod 会调用失败
    BOOL didiAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMehtod), method_getTypeEncoding(swizzledMehtod));
    
    //如果方法不存在， 我们就添加一个方法
    if (didiAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMehtod);
    }
    
    
    
    
}



@end
