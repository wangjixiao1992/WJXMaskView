//
//  ViewController.m
//  maskView
//
//  Created by wangjixiao on 2018/8/29.
//  Copyright © 2018年 王吉笑. All rights reserved.
//

#import "ViewController.h"
#import "WJXMaskView.h"


@interface ViewController ()<WJXMaskViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *view= [[UIImageView alloc] init];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    view.image = [UIImage imageNamed:@"timg"];
    [self.view addSubview:view];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    WJXMaskView *view1 = [[WJXMaskView alloc] init];
    view1.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    view1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    view1.delegate = self;
    [view1 maskViewWithRectangularMaskRect:CGRectMake(50, 50, 50, 50)
                                 maskImage:[UIImage imageNamed:@"timg"]
                                 imageRect:CGRectMake(120, 50, 50, 50)];
    [[UIApplication sharedApplication].keyWindow addSubview:view1];
}

/**
 *  视图被点击
 *
 */
- (void)WJXMaskViewDidClick:(WJXMaskView *)view
{
    [view maskViewWithRectangularMaskRect:CGRectMake(view.frame.origin.x + 50 + 10, 50, 50, 50)
                                maskImage:[UIImage imageNamed:@"timg"]
                                imageRect:CGRectMake(view.frame.origin.x + 50 + 50 + 20, 50, 50, 50)];
}



@end
