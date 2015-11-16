//
//  ZJReflectedView.m
//  Test
//
//  Created by 余志杰 on 15/11/12.
//  Copyright © 2015年 余志杰. All rights reserved.
//

#import "ZJReflectedView.h"

#define kRadianWithAngle(angle) (angle * M_PI / 180)

@interface ZJReflectedView ()

@property(nonatomic,strong) CALayer *backgroundLayer;
@property(nonatomic,strong) CALayer *protraitLayer;

@property(nonatomic,strong) CALayer         *imageLayer;
@property(nonatomic,strong) CALayer         *reflectlayer;
@property(nonatomic,strong) CAGradientLayer *maskLayer;

@end


@implementation ZJReflectedView


- (void)layoutSubviews{
    if (!_imageLayer.contents) {
        return;
    }

    [self backgroundLayer];
    [self protraitLayer];

    [super layoutSubviews];
    
    CGFloat selfViewHeight = self.layer.frame.size.height;
    CGFloat selfViewWidth = self.layer.frame.size.width;
    
    CGFloat imageLayerW = self.imageSize.width;
    CGFloat imageLayerH = self.imageSize.height;
    
    CGFloat padding = (selfViewWidth - imageLayerW)/2;

    CGFloat imageLayerX = padding;
    CGFloat imageLayerY = padding;
   
    
    self.imageLayer.frame = CGRectMake(imageLayerX, imageLayerY, imageLayerW, imageLayerH);
    
    CGFloat reflectlayerY = CGRectGetMaxY(self.imageLayer.frame);
    self.reflectlayer.frame = CGRectMake(imageLayerX, reflectlayerY, imageLayerW, imageLayerH);
    
    CGFloat maskHeight = selfViewHeight - reflectlayerY - padding;
    self.maskLayer.bounds = CGRectMake(0, 0, self.imageSize.width, maskHeight);
    [self.maskLayer setPosition:CGPointMake(self.imageSize.width/2,  self.imageSize.height - maskHeight * 0.5)];
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageLayer.contents = (__bridge id _Nullable)(image.CGImage);
    self.reflectlayer.contents = self.imageLayer.contents;
}

#pragma mark -
#pragma mark - lazy load

- (CALayer *)backgroundLayer{
    if (_backgroundLayer == nil) {
        _backgroundLayer =[[CALayer alloc] init];
        _backgroundLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _backgroundLayer.shadowColor = [UIColor grayColor].CGColor;
        _backgroundLayer.shadowOpacity = 1;
        _backgroundLayer.cornerRadius = 3;
        _backgroundLayer.shadowOffset = CGSizeMake(0, 1);
        _backgroundLayer.bounds = self.bounds;
        _backgroundLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        _backgroundLayer.transform = CATransform3DMakeRotation(kRadianWithAngle(10), 0, 0, 1);
        [self.layer insertSublayer:_backgroundLayer below:self.protraitLayer];
    }
    return _imageLayer;
}

- (CALayer *)protraitLayer{
    if (_protraitLayer == nil) {
        _protraitLayer = [[CALayer alloc] init];
        _protraitLayer.shadowColor = [UIColor grayColor].CGColor;
        _protraitLayer.shadowOpacity = 1;
        _protraitLayer.cornerRadius = 3;
        _protraitLayer.shadowOffset = CGSizeMake(0, 1);
        _protraitLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _protraitLayer.bounds = self.bounds;
        _protraitLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        [self.layer insertSublayer:_protraitLayer below:self.imageLayer];
    }
    return _protraitLayer;
}


- (CALayer *)imageLayer{
    if (_imageLayer == nil) {
        _imageLayer =[[CALayer alloc] init];
        _imageLayer.backgroundColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:_imageLayer];
    }
    return _imageLayer;
}

- (CALayer *)reflectlayer{
    if (_reflectlayer == nil) {
        _reflectlayer =[[CALayer alloc] init];
        _reflectlayer.backgroundColor = [UIColor blueColor].CGColor;
        _reflectlayer.transform = CATransform3DMakeRotation(kRadianWithAngle(180), 1, 0, 0);

        _reflectlayer.mask = self.maskLayer;
        [self.layer addSublayer:_reflectlayer];

    }
    return _reflectlayer;
}

- (CAGradientLayer *)maskLayer{
    if (_maskLayer == nil) {
        _maskLayer =[[CAGradientLayer alloc] init];
        [_maskLayer setColors:[NSArray arrayWithObjects: (id)[[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor],(id)[[[UIColor blackColor] colorWithAlphaComponent:0.7] CGColor], nil]];
        [_maskLayer setStartPoint:CGPointMake(0.5,0)];
        [_maskLayer setEndPoint:CGPointMake(0.5,1.0)];
    }
    return _maskLayer;
}
@end
