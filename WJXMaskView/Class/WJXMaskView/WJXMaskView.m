//
//  WJXMaskView.m
//  clutterTest
//
//  Created by wangjixiao on 2018/8/29.
//  Copyright © 2018年 王吉笑. All rights reserved.
//

#import "WJXMaskView.h"

@interface WJXMaskView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;


@end


@implementation WJXMaskView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

/**
 设置遮罩镂空 图片
 
 */
- (void)maskViewWithEllipseMaskRect:(CGRect)maskRect
                          maskImage:(UIImage *)maskImage
                          imageRect:(CGRect)imageRect
{
    for (CAShapeLayer *layer in [self.shapeLayer sublayers]) {
        [layer removeFromSuperlayer];
    }
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
    self.shapeLayer = nil;
    self.layer.mask = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:maskRect];
    [path appendPath:maskPath];
    self.shapeLayer.path = path.CGPath;
    self.layer.mask = self.shapeLayer;
    if (maskImage) {
        [self maskViewWithMaskImage:maskImage
                          imageRect:imageRect];
    }
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(viewClick:)];
    [self addGestureRecognizer:gesture];
}

/**
 设置遮罩镂空 图片
 
 */
- (void)maskViewWithRectangularMaskRect:(CGRect)maskRect
                              maskImage:(UIImage *)maskImage
                              imageRect:(CGRect)imageRect
{
    for (CAShapeLayer *layer in [self.shapeLayer sublayers]) {
        [layer removeFromSuperlayer];
    }
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
    self.shapeLayer = nil;
    self.layer.mask = nil;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    [path moveToPoint:CGPointMake(maskRect.origin.x, maskRect.origin.y)]; // 移动绘线原点(按逆时针绘制)
    [path addLineToPoint:CGPointMake(maskRect.origin.x, maskRect.origin.y + maskRect.size.height)];
    [path addLineToPoint:CGPointMake(maskRect.origin.x + maskRect.size.width, maskRect.origin.y + maskRect.size.height)];
    [path addLineToPoint:CGPointMake(maskRect.origin.x + maskRect.size.width, maskRect.origin.y)];
    path.usesEvenOddFillRule = YES; // 自动填充
    self.shapeLayer.path = path.CGPath;
    self.layer.mask = self.shapeLayer;
    if (maskImage) {
        [self maskViewWithMaskImage:maskImage
                          imageRect:imageRect];
    }
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(viewClick:)];
    [self addGestureRecognizer:gesture];
}
/**
 设置遮罩镂空 图片
 
 */
- (void)maskViewWithMaskImage:(UIImage *)maskImage
                    imageRect:(CGRect)imageRect
{
    [self addSubview:self.imageView];
    self.imageView.frame = imageRect;
    self.imageView.image = maskImage;
}


/**
 视图点击
 */
- (void)viewClick:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(WJXMaskViewDidClick:)]) {
        [self.delegate WJXMaskViewDidClick:self];
    }
}


#pragma mark - 懒加载
- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = self.bounds;
        _shapeLayer.fillColor = [UIColor blackColor].CGColor; // 非透明颜色即可
        _shapeLayer.fillRule = kCAFillRuleEvenOdd;
    }
    return _shapeLayer;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

@end
