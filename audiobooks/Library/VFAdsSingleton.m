//
//  VFAdMobSingleton.m
//  audiobooks
//
//  Created by Andrei Vidrasco on 3/24/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "VFAdsSingleton.h"

@implementation VFAdsSingleton
+ (id)sharedManager {
    static VFAdsSingleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
-(void)setAdMobTo:(id)viewC{
    _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    _bannerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-_bannerView.frame.size.height, _bannerView.frame.size.width, _bannerView.frame.size.height);
    
    // Specify the ad unit ID.
    _bannerView.adUnitID = AdMobAdUnitID;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    _bannerView.rootViewController = viewC;
    UIViewController *viewT = (UIViewController *)viewC;
    
    [viewT.view addSubview:_bannerView];
    
    // Initiate a generic request to load it with an ad.
    [_bannerView loadRequest:[GADRequest request]];

}
+(void)saveAnalytics:(NSString *)event{
    [Flurry logEvent:event];
    [Apsalar event:event];
    
}

@end
