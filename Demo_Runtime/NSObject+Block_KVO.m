//
//  NSObject+Block_KVO.m
//  Demo_Runtime
//
//  Created by game-netease-chuyou on 2018/6/7.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "NSObject+Block_KVO.h"
#import <objc/message.h>
#import <objc/runtime.h>

//kvo类的前缀
static NSString *const kvoClassPrefix_for_Block = @"Observer_";
static NSString *const kvoAssiociateObserver_for_Block = @"AssicoiateObserver";

@implementation NSObject (Block_KVO)

- (void)block_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    //1.获得setter方法，如果没有，抛出异常
    SEL setterSelector = NSSelectorFromString(setterForGetter(key));
    Method setterMettod = class_getInstanceMethod([self class], setterSelector);
    if (!setterSelector) {
        @throw [NSException exceptionWithName: NSInvalidArgumentException reason: [NSString stringWithFormat: @"unrecognized selector sent to instance %@", self] userInfo: nil];
        return;
    }
    
    //自己的类作为被观察的类
    Class observedClass = object_getClass(self);
    NSString *className = NSStringFromClass(observedClass);
    
    //如果被坚挺着没有observer_，那么判断是否需要创建新类
    if (![className hasPrefix:kvoClassPrefix_for_Block]) {
        //
        
        object_setClass(self, observedClass);
    }
    
}

- (Class)createKVOClassWithOriginalClassName:(NSString *)className
{
    NSString *kvoClassName = [kvoClassPrefix ];
}


@end
