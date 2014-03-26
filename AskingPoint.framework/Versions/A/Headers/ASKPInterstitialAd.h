//
//  ASKPInterstitialAd.h
//  AskingPoint
//
//  Copyright (c) 2013 KnowFu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASKPInterstitialAdDelegate;

@interface ASKPInterstitialAd : NSObject

@property(nonatomic, assign) id<ASKPInterstitialAdDelegate> delegate;
@property(nonatomic, readonly, getter=isLoaded) BOOL loaded;
- (BOOL)presentFromViewController:(UIViewController *)viewController;
@end


@protocol ASKPInterstitialAdDelegate <NSObject>
@optional
- (void)interstitialAdWillLoadAd:(ASKPInterstitialAd*)interstitialAd;
- (void)interstitialAdDidLoadAd:(ASKPInterstitialAd*)interstitialAd;
- (void)interstitialAd:(ASKPInterstitialAd*)interstitialAd didFailToLoadAdWithError:(NSError*)error;

- (void)interstitialAdWillAppear:(ASKPInterstitialAd*)interstitialAd;
- (void)interstitialAdWillDisappear:(ASKPInterstitialAd*)interstitialAd;
- (void)interstitialAdDidDisappear:(ASKPInterstitialAd*)interstitialAd;

- (void)didClickInterstitialAd:(ASKPInterstitialAd*)interstitialAd;
@end
