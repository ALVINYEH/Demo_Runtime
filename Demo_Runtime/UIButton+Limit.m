//
//  UIButton+Limit.m
//  Demo_Runtime
//
//  Created by game-netease-chuyou on 2018/6/5.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "UIButton+Limit.h"
#import <objc/runtime.h>

static const char *UIControl_accpetEventInterval = "UIControl_accpetEventInterval";
static const char *UIControl_ignoreEvent = "UIControl_ignoreEvent";

@implementation UIButton (Limit)

#pragma mark - acceptEventInterval

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_accpetEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_accpetEventInterval) doubleValue];
}

#pragma mark - ignoreEvent
- (void)setIgnoreEvent:(BOOL)ignoreEvent{
    objc_setAssociatedObject(self,UIControl_ignoreEvent, @(ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)ignoreEvent{
    return [objc_getAssociatedObject(self,UIControl_ignoreEvent) boolValue];
}

#pragma mark - Swizzling
+ (void)load
{
    Method fromMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method toMethod = class_getInstanceMethod(self, @selector(swizzled_sendAction:to:forEvent:));
    method_exchangeImplementations(fromMethod,toMethod);
}

- (void)swizzled_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.ignoreEvent) {
        NSLog(@"BtnAction is intercepted");
        return;
    }
    
    if (self.acceptEventInterval > 0) {
        self.ignoreEvent = YES;
        [self performSelector:@selector(setIgnoredWithNo) withObject:nil afterDelay:self.acceptEventInterval];
    }
    
    [self swizzled_sendAction:action to:target forEvent:event];
}

- (void)setIgnoredWithNo
{
    self.ignoreEvent = NO;
}




@end
