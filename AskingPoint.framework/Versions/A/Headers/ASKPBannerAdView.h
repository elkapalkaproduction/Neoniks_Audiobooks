//
//  ASKPBannerAdView.h
//  AskingPoint
//
//  Copyright (c) 2013 KnowFu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const ASKPAdErrorDomain;

typedef enum ASKPAdError {
    ASKPAdErrorSuccess = 0x0000,
    ASKPAdErrorServerFailure = 0x0001,                // Network error, unable to get an Ad
    ASKPAdErrorLoadingThrottled = 0x0002,             // Too many ads have been requested in too short a time
    ASKPAdErrorInventoryUnavailable = 0x0003,         // There is currently no ads inventory available
    ASKPAdErrorConfigurationError = 0x0004,           // This error can occurr if the AskingPoint Advertising Services
                                                      // are not enabled, improperly configured or not turned on for anApp.
    ASKPAdErrorBannerVisibleWithoutContent = 0x0101,  // The ad view is visible, but there is no ad being displayed
    ASKPAdErrorAdUnloaded = 0x0102,                   // The ad being displayed has become unavailable or expired
    ASKPAdErrorUnknown = 0xFFFF,                      // Unknown Error
} ASKPAdError;

typedef enum ASKPBannerAdSize {
    ASKPBannerAdSizeDefault = 0,    // 320x50 on iPhone, 728x90 on iPad
    ASKPBannerAdSizeMedium = 1      // 320x250
} ASKPBannerAdSize;

@protocol ASKPBannerAdViewDelegate;
@interface ASKPBannerAdView : UIView

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame delegate:(id<ASKPBannerAdViewDelegate>)delegate;
- (id)initWithFrame:(CGRect)frame adSize:(ASKPBannerAdSize)adSize delegate:(id<ASKPBannerAdViewDelegate>)delegate;

@property(nonatomic) ASKPBannerAdSize adSize;
@property(nonatomic,assign) IBOutlet id<ASKPBannerAdViewDelegate> delegate;
@property(nonatomic) BOOL autoRefresh;                                      // Turn ON/OFF Ad refreshing.
@property(nonatomic, readonly, getter=isLoaded) BOOL loaded;                // Returns YES if Ad currently loaded, else no

- (CGSize)intrinsicContentSize;     // Returns the Ads preferred size.
- (IBAction)fetchAd;                // Can be used to force request for banner (works while autoRefresh is OFF).
@end

@protocol ASKPBannerAdViewDelegate <NSObject>
@optional
- (void)bannerAdViewWillLoadAd:(ASKPBannerAdView*)bannerAdView;
- (void)bannerAdViewDidLoadAd:(ASKPBannerAdView*)bannerAdView;
- (void)bannerAdView:(ASKPBannerAdView*)bannerAdView didFailToLoadAdWithError:(NSError*)error;

- (void)bannerAdViewWillBeginAction:(ASKPBannerAdView*)bannerAdView;
- (void)bannerAdViewWillFinishAction:(ASKPBannerAdView*)bannerAdView;
- (void)bannerAdViewDidFinishAction:(ASKPBannerAdView*)bannerAdView;

- (void)bannerAdViewDidClick:(ASKPBannerAdView*)bannerAdView;
@end
