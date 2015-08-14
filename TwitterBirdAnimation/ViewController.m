//
//  ViewController.m
//  TwitterBirdAnimation
//
//  Created by Thomas Denney on 19/07/2014.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

#import "ViewController.h"

const CGFloat TwitterLogoMaskWidth = 1193;
const CGFloat TwitterLogoMaskHeight = 926;

@interface ViewController ()

@property CALayer * mask;
@property CAKeyframeAnimation * keyFrameAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //The view must be configured by this point, currently it is loaded from ViewController.xib
    
    self.mask = [CALayer layer];
    self.mask.contents = (__bridge id)([UIImage imageNamed:@"twitter logo mask"].CGImage);
    self.mask.bounds = CGRectMake(0, 0, TwitterLogoMaskWidth * 0.1, TwitterLogoMaskHeight * 0.1);
    self.mask.anchorPoint = CGPointMake(0.5, 0.5);
    //In iOS 8 the views bounds are 600 * 600 (when from instantiated from a XIB), so I have to use the screen bounds instead
    self.mask.position = CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetMidY([[UIScreen mainScreen] bounds]));
    self.view.layer.mask = self.mask;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //This animation should only occur when the app is first launched, not every time the VC appears
    if (self.mask.superlayer) {
        CAKeyframeAnimation * keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
        keyFrameAnimation.delegate = self;
        keyFrameAnimation.duration = 1;
        //Delay of one second after it has first appeared
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1; //add delay of 1 second
        
        CGRect initalBounds = self.mask.bounds;
        CGRect secondBounds = CGRectMake(0, 0, TwitterLogoMaskWidth * 0.075, TwitterLogoMaskHeight * 0.075);
        CGRect finalBounds = CGRectMake(0, 0, TwitterLogoMaskWidth * 2, TwitterLogoMaskHeight * 2);
        keyFrameAnimation.values = @[[NSValue valueWithCGRect:initalBounds],
                                     [NSValue valueWithCGRect:secondBounds],
                                     [NSValue valueWithCGRect:finalBounds]];
        keyFrameAnimation.keyTimes = @[@0, @0.3, @1];
        keyFrameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        
        self.keyFrameAnimation = keyFrameAnimation;
        [self.mask addAnimation:keyFrameAnimation forKey:@"bounds"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.mask removeFromSuperlayer];
}

@end
