//
//  EnumDictOneLevel.m
//  Demo_Runtime
//
//  Created by game-netease-chuyou on 2018/6/7.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "EnumDictOneLevel.h"
#import <objc/runtime.h>

const char *propertyListKey1 = "PropertyListKey1";
@implementation EnumDictOneLevel

+ (instancetype)modelWithDict1:(NSDictionary *)dict
{
    //实例化对象
    id model = [[self alloc] init];
    
    //使用字典，设置对象信息
    //1. 获得self的属性列表
    NSArray *propertyList = [self objcProperties];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([propertyList containsObject:key]) {
            if (obj) {
                [model setValue:obj forKey:key];
            }
        }
    }];
    
    return model;
}

+ (NSArray *)objcProperties
{
    NSArray *propertyList = objc_getAssociatedObject(self, propertyListKey1);
    
    if (propertyList) {
        return propertyList;
    }
    
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
    NSMutableArray *mtArray = [NSMutableArray array];
    
    for (unsigned int i = 0; i < outCount; i++) {
        objc_property_t property = (propertyList[i]);
        
        const char *propertyName_C = property_getName(property);
        
        NSString *propertyName_OC = [NSString stringWithCString:propertyName_C encoding:NSUTF8StringEncoding];
        [mtArray addObject:propertyName_OC];
        
        objc_setAssociatedObject(self, propertyListKey1, mtArray.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        /* 释放 */
        free(propertyList);
        return mtArray.copy;
        
    }
}

@end
