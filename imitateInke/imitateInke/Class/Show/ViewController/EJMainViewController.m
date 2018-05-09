//
//  EJMainViewController.m
//  imitateInke
//
//  Created by J Echoo on 2018/5/6.
//  Copyright © 2018年 J.Echoo. All rights reserved.
//

#import "EJMainViewController.h"
#import "EJMainTopView.h"
@interface EJMainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray *datalist;
@property (nonatomic, strong) EJMainTopView * topView;
@end

@implementation EJMainViewController

- (EJMainTopView *)topView {

    if (!_topView) {
        _topView = [[EJMainTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.datalist];

        @weakify(self);
       // __weak typeof(self) weakself=self;
        _topView.block = ^(NSInteger tag) {
            @strongify(self);
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
            [self.contentScrollView setContentOffset:point animated:YES];

        };
    }
    return _topView;
}

- (NSArray *)datalist {
    
    if (!_datalist) {
        _datalist = @[@"关注",@"热门",@"附近"];
    }
    return _datalist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)initUI{
    [self.view addSubview:self.contentScrollView];
    [self setupNav];
    [self setupChildViewControllers];
}
- (void)setupNav {
    
    self.navigationItem.titleView = self.topView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)setupChildViewControllers{
    
    NSArray * vcNames = @[@"EJFocusViewController",@"EJHotViewController",@"EJNearViewController"];
    
    for (NSInteger i = 0; i < vcNames.count; i ++) {
        NSString * vcName = vcNames[i];
        
        UIViewController * vc = [[NSClassFromString(vcName) alloc] init];
        vc.title = self.datalist[i];
        //当执行这句话addChildViewController时，不会执行该vc的viewdidload
        [self addChildViewController:vc];
        
    }
    //将子控制器的view，加到MainVC的scrollview上
    
    //设置scrollview的contentsize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.datalist.count, 0);
    
    //默认先展示第二个页面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
   //进入主控制器加载第一个页面
   [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

//减速结束时调用加载子控制器view的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
//动画结束调用代理
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = SCREEN_WIDTH;//scrollView.frame.size.width;
    
    //CGFloat height = SCREEN_HEIGHT - 64 - 49;
    CGFloat height = SCREEN_HEIGHT;
    
    CGFloat offset = scrollView.contentOffset.x;
    //获取索引值
    NSInteger idx = offset / width;
    
    //索引值联动topView
    [self.topView scrolling:idx];
    
    //根据索引值返回vc引用
    UIViewController * vc = self.childViewControllers[idx];
    
    //判断当前vc是否执行过viewdidLoad
    if ([vc isViewLoaded]) return;
    
    //设置子控制器view的大小
    vc.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, height);
    //将子控制器的view加入scrollview上
    [scrollView addSubview:vc.view];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
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
