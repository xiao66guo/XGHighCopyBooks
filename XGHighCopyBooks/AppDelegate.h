//
//  AppDelegate.h
//  XGHighCopyBooks
//
//  Created by 小果 on 2017/1/4.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIPageViewControllerDataSource>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UIPageViewController *pageVC;


@end

