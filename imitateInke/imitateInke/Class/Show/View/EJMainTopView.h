//
//  EJMainTopView.h
//  imitateInke
//
//  Created by J Echoo on 2018/5/8.
//  Copyright © 2018年 J.Echoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainTopBlock)(NSInteger tag);

@interface EJMainTopView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles;

@property (nonatomic, copy) MainTopBlock block;

- (void)scrolling:(NSInteger)tag;

@end
