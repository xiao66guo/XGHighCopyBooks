//
//  XGPageViewController.h
//  XGHighCopyBooks
//
//  Created by 小果 on 2017/1/4.
//  Copyright © 2017年 小果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XGPageViewController : UIViewController
@property (assign, nonatomic) NSUInteger pageIndex;

- (id)initWithPageNumber:(NSInteger)pageNumber;
@end
