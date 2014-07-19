//
//  ViewController.m
//  TwitterBirdAnimation
//
//  Created by Thomas Denney on 19/07/2014.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UIImageView * imageView;
@property CALayer * mask;
@property CAKeyframeAnimation * keyFrameAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //N.B. I renamed the twitterscreen.png file to twitterscreen@2x.png because otherwise
    //the image view created here is twice the width and height of the screen
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twitterscreen"]];
    [self.view addSubview:self.imageView];
    
    self.mask = [CALayer layer];
    self.mask.contents = (__bridge id)([UIImage imageNamed:@"twitter logo mask"].CGImage);
    self.mask.bounds = CGRectMake(0, 0, 100, 100);
    self.mask.anchorPoint = CGPointMake(0.5, 0.5);
    self.mask.position = CGPointMake(CGRectGetMidX(self.imageView.bounds), CGRectGetMidY(self.imageView.bounds));
    
    self.imageView.layer.mask = self.mask;
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
        CGRect secondBounds = CGRectMake(0, 0, 90, 90);
        CGRect finalBounds = CGRectMake(0, 0, 1500, 1500);
        keyFrameAnimation.values = @[[NSValue valueWithCGRect:initalBounds],
                                     [NSValue valueWithCGRect:secondBounds],
                                     [NSValue valueWithCGRect:finalBounds]];
        //N.B. @1 -> [NSNumber numberWithInt:1]
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
