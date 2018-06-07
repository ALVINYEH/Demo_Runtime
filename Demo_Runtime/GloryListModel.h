//
//  GloryListModel.h
//  Demo_Runtime
//
//  Created by game-netease-chuyou on 2018/6/7.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GloryListModel : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *targetVC;

@property (nonatomic, copy) NSString *menuCode;

+ (instancetype)gloryListModelWithDict:(NSDictionary *)dict;

+ (NSArray<GloryListModel *> *)gloryListModelsWithPlistName:(NSString *)plistName;

@end
