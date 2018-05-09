//
//  EJBaseNavViewController.m
//  imitateInke
//
//  Created by J Echoo on 2018/5/6.
//  Copyright © 2018年 J.Echoo. All rights reserved.
//

#import "EJBaseNavViewController.h"

@interface EJBaseNavViewController ()

@end

@implementation EJBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor=RGB(0, 216, 201);
    self.navigationBar.tintColor=RGB(255, 255, 255);
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
