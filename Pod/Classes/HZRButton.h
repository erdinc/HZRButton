//
//  HZRButton.h
//  AutoLayoutTest
//
//  Created by Erdinc Akkaya on 11/11/14.
//  Copyright (c) 2014 Erdinc Akkaya. All rights reserved.
//


#import <UIKit/UIKit.h>

@class HZRButton;

@protocol HZRButtonDelegate
@required - (void)animatingButtonDidFinishLoading:(HZRButton *)button;
@end

@interface HZRButton : UIButton

@property (nonatomic, weak) id<HZRButtonDelegate> delegate;
@property (nonatomic, assign) int progressBarHeight;

- (void)updatePercentage:(CGFloat)percentDone;

@end
