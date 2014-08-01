//
//  AppDelegate.h
//  audiobooks
//
//  Created by Andrei Vidrasco on 3/21/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogoViewController.h"
#import "MKStoreManager.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) LogoViewController *viewController;
@property (strong, nonatomic) UINavigationController *navController;

@property (strong, nonatomic) UIWindow *window;

@end