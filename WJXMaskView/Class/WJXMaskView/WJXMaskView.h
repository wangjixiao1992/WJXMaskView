//
//  WJXMaskView.h
//  clutterTest
//
//  Created by wangjixiao on 2018/8/29.
//  Copyright © 2018年 王吉笑. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJXMaskView;

@protocol WJXMaskViewDelegate <NSObject>

@optional

/**
 *  视图被点击
 *
 */
- (void)WJXMaskViewDidClick:(WJXMaskView *)view;

@end


@interface WJXMaskView : UIView

@property (nonatomic, weak) id<WJXMaskViewDelegate> delegate;


/**
 设置遮罩镂空 图片
 
 */
- (void)maskViewWithEllipseMaskRect:(CGRect)maskRect
                          maskImage:(UIImage *)maskImage
                          imageRect:(CGRect)imageRect;

/**
 设置遮罩镂空 图片
 
 */
- (void)maskViewWithRectangularMaskRect:(CGRect)maskRect
                              maskImage:(UIImage *)maskImage
                              imageRect:(CGRect)imageRect;


@end
