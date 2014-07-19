//
//  AppDelegate.m
//  TwitterBirdAnimation
//
//  Created by Thomas Denney on 19/07/2014.
//  Copyright (c) 2014 Rounak Jain. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    self.window.rootViewController = [ViewController new];
    
    return YES;
}

@end
