//
//  GloryListModel.m
//  Demo_Runtime
//
//  Created by game-netease-chuyou on 2018/6/7.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "GloryListModel.h"


//有一个排名列表页面，这个页面的每个排名对应一个模型，这个模型从Plist转换得到。

@implementation GloryListModel

//kvc 字典转模型
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

//防止与后台字段不匹配而造成崩溃
//必须保证，模型中的属性和字典中的key一一对应。
//如果不一致，就会调用[<Status 0x7fa74b545d60> setValue:forUndefinedKey:]
//报key找不到的错。
//分析:模型中的属性和字典的key不一一对应，系统就会调用setValue:forUndefinedKey:报错。
//解决:重写对象的setValue:forUndefinedKey:,把系统的方法覆盖，
//就能继续使用KVC，字典转模型了。

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

+ (instancetype)gloryListModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray<GloryListModel *> *)gloryListModelsWithPlistName:(NSString *)plistName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *modelArr = [NSMutableArray array];
    
    [dictArr enumerateObjectsUsingBlock:^(NSDictionary*  dict, NSUInteger idx, BOOL * _Nonnull stop) {
        [modelArr addObject:[self gloryListModelWithDict:dict]];
    }];
    
    return modelArr.copy;
    
}

@end
