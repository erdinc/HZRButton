//
//  HZRButton.m
//  AutoLayoutTest
//
//  Created by Erdinc Akkaya on 11/11/14.
//  Copyright (c) 2014 Erdinc Akkaya. All rights reserved.
//

#define PROGRESSBAR_OPACITY 0.4f
#define CHECKMARK_OPACITY 0.5f

#import <QuartzCore/QuartzCore.h>
#import "HZRButton.h"

@interface HZRButton()
@property (nonatomic, strong) CALayer *progressBar;
@property (nonatomic, strong) CALayer *checkMarkLayer;
@end

@implementation HZRButton

- (instancetype)init{
    self = [super init];
    if(self){
        _progressBarHeight = 4;
        [self setupLoadingLayer];
        [self setupButton];
    }
    return self;
}

- (void)setupButton{
    static NSString *fontName = @"HelveticaNeue-Bold";
    self.titleLabel.font = [UIFont fontWithName:fontName size:14];
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
}

- (void)animationDidStop:(CAAnimation *) __unused theAnimation finished:(BOOL) __unused flag{
    
    CALayer *presentationLayer = self.progressBar.presentationLayer;
    
    if(presentationLayer.bounds.size.width == self.bounds.size.width){
        
        [CATransaction begin];

        CABasicAnimation *fadeOutLoadingBar = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeOutLoadingBar.fromValue = @(PROGRESSBAR_OPACITY);
        fadeOutLoadingBar.toValue = @(0);
        fadeOutLoadingBar.fillMode = kCAFillModeForwards;
        fadeOutLoadingBar.beginTime = [self.progressBar convertTime:CACurrentMediaTime() fromLayer:nil];
        fadeOutLoadingBar.duration = .8;
        fadeOutLoadingBar.removedOnCompletion = NO;
        [self.progressBar addAnimation:fadeOutLoadingBar forKey:nil];
        
        [self setupCheckMarkLayer];
        CABasicAnimation *fadeOutCheckMark = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeOutCheckMark.fromValue = @(CHECKMARK_OPACITY);
        fadeOutCheckMark.toValue = @(0);
        fadeOutCheckMark.fillMode = kCAFillModeForwards;
        fadeOutCheckMark.beginTime = [self.checkMarkLayer convertTime:CACurrentMediaTime() fromLayer:nil] + 0.5;
        fadeOutCheckMark.duration = 1.0;
        fadeOutCheckMark.removedOnCompletion = NO;
        self.checkMarkLayer.opacity = 0.;
        [self.checkMarkLayer addAnimation:fadeOutCheckMark forKey:nil];
        
        __block id<HZRButtonDelegate> delegate= self.delegate;
        [CATransaction setCompletionBlock:^{
            self.userInteractionEnabled = YES;
            [delegate animatingButtonDidFinishLoading:self];
            [self setupLoadingLayer];
        }];
        [CATransaction commit];
    }
}

- (void)updatePercentage:(CGFloat)percentDone{
    percentDone = percentDone > 1.f ? 1.f : percentDone;
    self.userInteractionEnabled = NO;
    __block NSString *animationKeyPath = @"bounds.size.width";
    __block CGFloat loadingDone = ceilf(self.bounds.size.width * percentDone);

    if(loadingDone == self.progressBar.bounds.size.width){
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:animationKeyPath];
        animation.delegate = self;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [animation setValue:@(loadingDone) forKey:animationKeyPath];
        
        animation.duration = 1.0 - percentDone;
        
        CGRect loadingRect = self.progressBar.bounds;
        loadingRect.size.width = loadingDone;
        
        self.progressBar.bounds = loadingRect;
        [self.progressBar addAnimation:animation forKey:nil];

    });

}


#pragma mark - Setup Layers

- (void)setupCheckMarkLayer{
    UIImage *checkMark = [UIImage imageNamed:@"checkmark"];
    self.checkMarkLayer = [CALayer layer];
    self.checkMarkLayer.contents = (__bridge id)(checkMark.CGImage);
    self.checkMarkLayer.opacity = CHECKMARK_OPACITY;
    
    self.checkMarkLayer.bounds = CGRectMake(0, 0,checkMark.size.width,checkMark.size.height);
    CGFloat checkMarkOriginY = ceilf((self.bounds.size.height - checkMark.size.height) / 2);
    CGFloat checkMarkOriginX = self.frame.size.width - checkMark.size.width - 8;
    self.checkMarkLayer.anchorPoint = CGPointZero;
    self.checkMarkLayer.position = CGPointMake(checkMarkOriginX, checkMarkOriginY);
    [self.layer addSublayer:self.checkMarkLayer];
}

- (void)setupLoadingLayer{
    self.progressBar = [CALayer layer];
    self.progressBar.anchorPoint = CGPointZero;
    self.progressBar.backgroundColor = [UIColor blackColor].CGColor;
    self.progressBar.opacity = PROGRESSBAR_OPACITY;
    self.progressBar.frame = CGRectMake(0, 0, 0, _progressBarHeight);
    [self.layer addSublayer:self.progressBar];
}

@end
