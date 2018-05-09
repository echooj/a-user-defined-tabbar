//
//  EJTabBar.h
//  imitateInke
//
//  Created by J Echoo on 2018/5/6.
//  Copyright © 2018年 J.Echoo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, EJItemtype) {
    
    EJItemTypeLaunch = 10,//启动直播
    EJItemTypeLive = 100,//展示直播
    EJItemTypeMe, //我的

};
@class EJTabBar;

typedef void(^TabBlock) (EJTabBar *tabbar, EJItemtype idx);

@protocol EJTabBarDelegate <NSObject>
-(void)tabbar:(EJTabBar *)tabbar clickButton:(NSUInteger) idx;
@end

@interface EJTabBar : UIView
@property (nonatomic,weak) id<EJTabBarDelegate> delegate;
@property (nonatomic,copy) TabBlock block;
@end
