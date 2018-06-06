//
//  UIButton+Limit.h
//  Demo_Runtime
//
//  Created by game-netease-chuyou on 2018/6/5.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Limit)

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval;
- (NSTimeInterval)acceptEventInterval;
- (BOOL)ignoreEvent;
@end
