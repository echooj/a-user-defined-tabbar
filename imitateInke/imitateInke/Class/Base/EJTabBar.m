//
//  EJTabBar.m
//  imitateInke
//
//  Created by J Echoo on 2018/5/6.
//  Copyright © 2018年 J.Echoo. All rights reserved.
//

#import "EJTabBar.h"

@interface EJTabBar()

@property (nonatomic, strong) UIImageView *tabbarView;
@property (nonatomic, strong) NSArray *datalist;
@property (nonatomic, strong) UIButton *lastbuttom;
@property (nonatomic, strong) UIButton *cameraButton;

@end


@implementation EJTabBar

- (UIButton *)cameraButton{
    if(!_cameraButton)
    {
        _cameraButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_cameraButton sizeToFit];
        _cameraButton.tag= EJItemTypeLaunch;
        [_cameraButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cameraButton;
}

-(UIImageView *)tabbarView{
    
    if(!_tabbarView){
        _tabbarView=[[UIImageView alloc] initWithImage: [UIImage imageNamed:@"global_tab_bg"]];
//       CGFloat a=_tabbarView.frame.size.height;
//       NSLog(@"%lf",a);
    }
    return _tabbarView;
}
-(NSArray *)datalist{
    if(!_datalist){
        _datalist =@[@"tab_live",@"tab_me"];
    }
    return _datalist;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tabbarView];
        for(NSInteger i=0;i<self.datalist.count;i++){
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            
            item.adjustsImageWhenHighlighted=NO;
            [item setImage:[UIImage imageNamed:self.datalist[i]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:[self.datalist[i] stringByAppendingString:@"_p"]]  forState:UIControlStateSelected];
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
           //一开始忘记写了，导致没有赋tag值
            item.tag=EJItemTypeLive+i;
            
            if(i==0){
                item.selected=YES;
                self.lastbuttom=item;
            }
            [self addSubview:item];
        }
        //添加直播按钮
        [self addSubview:self.cameraButton];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
//

    self.tabbarView.frame = self.bounds;
    //计算每一个button的宽度
    CGFloat width = self.bounds.size.width / self.datalist.count;
    
    for (NSInteger i = 0; i < [self subviews].count; i ++)
    {
        
        UIView * btn =  [self subviews][i];
        
        if ([btn isKindOfClass:[UIButton class]]) {
            
            btn.frame = CGRectMake((btn.tag - EJItemTypeLive) * width, 0, width, self.frame.size.height);
            
        }
        
    }
    
    [self.cameraButton sizeToFit];
    self.cameraButton.center = CGPointMake(self.bounds.size.width / 2 , 0);
}



- (void)clickItem:(UIButton *)button {
    //如果走代理走代理
    if ([self.delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
        [self.delegate tabbar:self clickButton:button.tag];
    }
    
    //如果走block 走block
    if (self.block) {
        self.block(self,button.tag);
    }

    if (button.tag == EJItemTypeLaunch) {
        return;
    }
    
    self.lastbuttom.selected = NO;
    button.selected = YES;
    self.lastbuttom= button;
    
    //设置动画
    [UIView animateWithDuration:0.2 animations:^{
        //将button扩大1.2倍
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            //恢复原始状态
            button.transform = CGAffineTransformIdentity;
        }];
    }];
    
}





@end
