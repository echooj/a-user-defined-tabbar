//
//  EJTabBarViewController.m
//  imitateInke
//
//  Created by J Echoo on 2018/5/6.
//  Copyright © 2018年 J.Echoo. All rights reserved.
//

#import "EJTabBarViewController.h"
#import "EJTabBar.h"
#import "EJBaseNavViewController.h"
#import "EJLaunchViewController.h"

@interface EJTabBarViewController ()<EJTabBarDelegate>
@property (nonatomic,strong) EJTabBar *ejTabBar;
@end

@implementation EJTabBarViewController

-(void)tabbar:(EJTabBar *)tabbar clickButton:(NSUInteger) idx{
   
    if(idx!=EJItemTypeLaunch){
         self.selectedIndex=idx-EJItemTypeLive;
        return;
    }
    EJLaunchViewController *launchVC=[[EJLaunchViewController alloc]init];
    [self presentViewController:launchVC animated:YES completion:nil];
    
}

-(EJTabBar *)ejTabBar{
    if(!_ejTabBar)
    {
        _ejTabBar =[[EJTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _ejTabBar.delegate= self;
    }
    return _ejTabBar;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configViewControllers];
    [self.tabBar addSubview:self.ejTabBar];
    //删除tabbar的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
    
}
- (void) configViewControllers{
    NSMutableArray * array = [NSMutableArray arrayWithArray:@[@"EJMainViewController",@"EJMeViewController"]];
    
    for (NSInteger i = 0; i < array.count; i ++) {
        
        NSString * vcName = array[i];
        
        UIViewController * vc = [[NSClassFromString(vcName) alloc] init];
        
        EJBaseNavViewController * nav = [[EJBaseNavViewController alloc] initWithRootViewController:vc];
        
        [array replaceObjectAtIndex:i withObject:nav];
        
    }
    
    self.viewControllers = array;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
