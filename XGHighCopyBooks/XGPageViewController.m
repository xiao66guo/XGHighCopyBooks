//
//  XGPageViewController.m
//  XGHighCopyBooks
//
//  Created by 小果 on 2017/1/4.
//  Copyright © 2017年 小果. All rights reserved.
//

#import "XGPageViewController.h"
#import "NSString+Extension.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define BtnFontSize 20

@interface XGPageViewController ()
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) NSArray *coverArray;
@property (nonatomic, weak) UIButton *singleBtn;
@property (nonatomic, weak) UIButton *doubleBtn;
@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, weak) UIButton *BeautifBtn;
@end

@implementation XGPageViewController

- (id)initWithPageNumber:(NSInteger)pageNumber
{
    self.contentArray = [NSArray arrayWithObjects:@"首席的抢手小小妻",@"美女老师的全能高手",@"恋上22岁绝美总裁",@"问佛",@"宝宝心里苦啊",@"逍遥小神农",@"上海请不要为我悲伤",@"帝姬江山",@"冷酷校草温柔妻",@"老婆别闹了",nil];
    
    self.coverArray = [NSArray arrayWithObjects:@"1.jpeg",@"2.jpeg",@"3.jpeg",@"4.jpeg",@"5.jpeg",@"6.jpeg",@"7.jpeg",@"8.jpeg",@"9.jpeg",@"10.jpeg", nil];
    
    self.pageIndex = pageNumber;
    if (self = [super initWithNibName:nil bundle:nil]){
        
//        self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:250/255.0 blue:253/255.0 alpha:1.0];
        self.view.backgroundColor = [UIColor lightGrayColor];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 90, 30)];
        [self btnWith:btn sizeFont:BtnFontSize name:@"双面效果"];
        self.doubleBtn = btn;
        [self.view addSubview:btn];
        
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(110, 30, 90, 30)];
        [self btnWith:btn1 sizeFont:BtnFontSize name:@"单面效果"];
        self.singleBtn = btn1;
        [self.view addSubview:btn1];
        
        // 创建页数标签
        UILabel* label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:25];
        label.textColor = [UIColor blueColor];
        label.textAlignment = NSTextAlignmentRight;
        label.text = [NSString stringWithFormat:@"第%zd页", pageNumber + 1];
        CGSize labSize = [label.text sizeWithFont:[UIFont boldSystemFontOfSize:40] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGFloat labX = ScreenW - labSize.width;
        CGFloat labY = 20;
        label.frame = CGRectMake(labX, labY, labSize.width, labSize.height);
        [self.view addSubview:label];
        
        // 创建图书名字标签
        UILabel* book = [[UILabel alloc] init];
        book.textAlignment = NSTextAlignmentCenter;
        book.numberOfLines = 0;
        book.font = [UIFont boldSystemFontOfSize:30];
        book.textColor = [UIColor redColor];
        book.text = [_contentArray objectAtIndex:pageNumber % _contentArray.count];
        CGSize booKSize = [book.text sizeWithFont:[UIFont boldSystemFontOfSize:30] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGFloat bookX = (ScreenW - booKSize.width) * 0.5;
        CGFloat bookY = CGRectGetMaxY(label.frame);
        book.frame = CGRectMake(bookX, bookY, booKSize.width, booKSize.height);
        [self.view addSubview:book];
        
        // 创建用来显示图片控件
        UIImageView* bookImage = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenW - 350) * 0.5, CGRectGetMaxY(book.frame)+ 20, 350, 500)];
        self.imageV = bookImage;
        // 设置该控件的图片缩放模式
        bookImage.contentMode = UIViewContentModeScaleAspectFit;
        // 设置要显示的图片
        bookImage.image = [UIImage imageNamed:[_coverArray objectAtIndex:pageNumber % _coverArray.count]];
        bookImage.layer.shadowOpacity = 1.0;
        bookImage.layer.shadowOffset = CGSizeMake(0, 0);
        bookImage.layer.shadowColor = [UIColor greenColor].CGColor;
        bookImage.layer.shadowRadius = 20;
        [self.view addSubview:bookImage];
    }
    return self;
}

#pragma mark - 抽取按钮的共有属性
-(void)btnWith:(UIButton *)sender sizeFont:(CGFloat)font name:(NSString *)name{
    [sender setTitle:name forState:UIControlStateNormal];
    
    [sender addTarget:self action:@selector(doubleAndSingleFace:) forControlEvents:UIControlEventTouchUpInside];
    
    [sender addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchDown];
    [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:font];
    
    sender.titleLabel.layer.shadowColor = [UIColor greenColor].CGColor;
    sender.titleLabel.layer.shadowOffset = CGSizeMake(5, 5);
    sender.titleLabel.layer.shadowRadius = 1;
    sender.titleLabel.layer.shadowOpacity = 0.9;
}

#pragma mark - 执行点击的方法并发出通知
-(void)doubleAndSingleFace:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"doubleAndSingleFace" object:self userInfo:@{@"btn":sender.titleLabel.text}];
}

#pragma mark - 点击按钮执行的动画
-(void)startAnimation{
    CATransition *anim = [CATransition animation];
    anim.type = @"rippleEffect";
    anim.repeatCount = 1;
    anim.duration = 2.0;
    [self.imageV.layer addAnimation:anim forKey:nil];
    
    CATransition *ani = [CATransition animation];
    ani.type = @"cube";
    ani.repeatCount = 1;
    ani.duration = 1.0;
    [self.doubleBtn.layer addAnimation:ani forKey:nil];
    [self.singleBtn.layer addAnimation:anim forKey:nil];
    
}


@end
