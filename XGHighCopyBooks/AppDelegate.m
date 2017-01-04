//
//  AppDelegate.m
//  XGHighCopyBooks
//
//  Created by 小果 on 2017/1/4.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "AppDelegate.h"
#import "XGPageViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupDoubleAndSingleFace:) name:@"doubleAndSingleFace" object:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 创建XGPageViewController控制器
    XGPageViewController *page = [[XGPageViewController alloc]
                                  initWithPageNumber:0];
    // 创建一个NSDictionary对象，作为创建UIPageViewController的选项。
    // 此处只支持2个key：
    // UIPageViewControllerOptionSpineLocationKey：指定翻页效果中书棱的位置
    // UIPageViewControllerOptionInterPageSpacingKey：指定2个页面之间间距
    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],UIPageViewControllerOptionSpineLocationKey, [NSNumber numberWithFloat:0], UIPageViewControllerOptionInterPageSpacingKey, nil];
    // 创建UIPageViewController
    UIPageViewController *pageVC =
    [[UIPageViewController alloc]
     // 设置页面过度效果(过度的效果有两种：一种是卷动的效果，一种是平移的效果）：此处使用书页卷动的翻页效果
     initWithTransitionStyle:0
     // 设置页面的翻页方向（翻页的方向有两种：一种是垂直的效果，一种是水平的效果）：此处使用水平翻页
     navigationOrientation:0 options:options];
    self.pageVC = pageVC;
    
    // 设置数据源代理
    pageVC.dataSource = self;
    // 设置pageVC管理的控制器
    // 指定向前翻页: UIPageViewControllerNavigationDirectionForward
    [pageVC setViewControllers:@[page] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    // 设置程序窗口的根控制器为pageViewController
    self.window.rootViewController = pageVC;
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark - 当pageVC向前翻页时调用该方法
- (XGPageViewController *)pageViewController:(UIPageViewController *)pvc
          viewControllerBeforeViewController:(XGPageViewController *)vc{
    // 如果当前pageIndex大于0，将pageIndex-1作为参数创建XGPageViewController
    NSUInteger index = vc.pageIndex;
    if (vc.pageIndex > 0)
    {
        return [[XGPageViewController alloc] initWithPageNumber:index - 1];
    }
    else{
        return [[XGPageViewController alloc] initWithPageNumber:index];
    }
}

#pragma mark - 当pageVC向后翻页时调用该方法
- (XGPageViewController *)pageViewController:(UIPageViewController *)pvc
           viewControllerAfterViewController:(XGPageViewController *)vc{
    // 将pageIndex-1作为参数创建XGPageViewController
    NSUInteger index = vc.pageIndex;
    //    if (index >= 9) {
    //        return nil;
    //    }else{
    
    return [[XGPageViewController alloc] initWithPageNumber:index + 1];
    //    }
}

#pragma mark - 接到通知后执行的方法
-(void)setupDoubleAndSingleFace:(NSNotification *)notify{
    
    NSString *str = notify.userInfo[@"btn"];
    if ([str isEqualToString:@"双面效果"]){
        self.pageVC.doubleSided = YES;
    }else{
        self.pageVC.doubleSided = NO;
    }
    
}

#pragma mark - 移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
