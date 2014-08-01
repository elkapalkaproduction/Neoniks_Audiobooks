//
//  ViewController.m
//  audiobooks
//
//  Created by Andrei Vidrasco on 3/21/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "ViewController.h"
#import "AudioBookViewController.h"
#import "ContributorsViewController.h"
#import "AudioPlayer.h"
#import "ChartboostDelegates.h"
#import "Chartboost.h"
#import <AdColony/AdColony.h>
#import "VFAdsSingleton.h"
#import "GADInterstitial.h"

@interface ViewController ()
@property (strong, nonatomic) GADBannerView *bannerView;
@property (strong, nonatomic) IBOutlet UIImageView *mainTitleImage;
@property (strong, nonatomic) IBOutlet UIButton *languageButton;
@property (strong, nonatomic) IBOutlet UIButton *guestCoverButton;
@property (strong, nonatomic) IBOutlet UIButton *cakeCoverButton;
@property (strong, nonatomic) IBOutlet UIButton *waterCoverButton;
@property (strong, nonatomic) IBOutlet UIButton *carnivalCoverButton;
@property (strong, nonatomic) IBOutlet UIButton *parcelCoverButton;
@property (strong, nonatomic) IBOutlet UIButton *fountainCoverButton;
@property (strong, nonatomic) GADInterstitial *interstitial;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[VFAdsSingleton sharedManager] setAdMobTo:self];
    
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = AdMobOnStart;
    [self.interstitial loadRequest:[GADRequest request]];
    [NSTimer scheduledTimerWithTimeInterval:60*10 target:self selector:@selector(showChartboost) userInfo:nil repeats:YES];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)showChartboost {
    [[Chartboost sharedChartboost] showInterstitial:CBLocationMainMenu];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [Chartboost startWithAppId:ChartboostAppID
                  appSignature:ChartboostAppSignature
                      delegate:nil];
    [self showChartboost];
    if ([AdColony zoneStatusForZone:AdColonyOnStartZone] == ADCOLONY_ZONE_STATUS_ACTIVE) {
        [AdColony playVideoAdForZone:AdColonyOnStartZone withDelegate:nil];
    } else {
        [self.interstitial presentFromRootViewController:self];
    }


    
}
-(void)viewWillAppear:(BOOL)animated{
    if (IS_PHONE4) {
        [VFUtils changeYPos:158 forItem:_guestCoverButton];
        [VFUtils changeYPos:158 forItem:_cakeCoverButton];
        [VFUtils changeYPos:158 forItem:_waterCoverButton];
        
        [VFUtils changeYPos:296 forItem:_carnivalCoverButton];
        [VFUtils changeYPos:296 forItem:_parcelCoverButton];
        [VFUtils changeYPos:296 forItem:_fountainCoverButton];
    }

    [super viewWillAppear:animated];
    [self updateLanguage];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateLanguage{
    [_mainTitleImage setImage:[VFUtils imageWithName:@"magic_fairy_tales"]];
    [_languageButton setBackgroundImage:[VFUtils imageWithName:@"language"] forState:UIControlStateNormal];
    [_guestCoverButton setBackgroundImage:[VFUtils imageWithName:guestTitle] forState:UIControlStateNormal];
    [_cakeCoverButton setBackgroundImage:[VFUtils imageWithName:cakeTitle] forState:UIControlStateNormal];
    [_waterCoverButton setBackgroundImage:[VFUtils imageWithName:waterTitle] forState:UIControlStateNormal];
    [_carnivalCoverButton setBackgroundImage:[VFUtils imageWithName:carnivalTitle] forState:UIControlStateNormal];
    [_parcelCoverButton setBackgroundImage:[VFUtils imageWithName:parcelTitle] forState:UIControlStateNormal];
    [_fountainCoverButton setBackgroundImage:[VFUtils imageWithName:fountainTitle] forState:UIControlStateNormal];
}
- (IBAction)changeLanguage:(id)sender {
    [[AudioPlayer sharedManager] stop];
        if (kRussian) {
            kSetEnglish;
        } else {
            kSetRussian;
        }
    [VFAdsSingleton saveAnalytics:@"Language is switched"];

        [self updateLanguage];
}
- (IBAction)goToContributors:(id)sender {
    [VFAdsSingleton saveAnalytics:@"Contributors button is clicked"];
    ContributorsViewController *audioBook = [[ContributorsViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:audioBook animated:YES];

}
- (IBAction)goToRateOnStore:(id)sender {
    NSURL *url = [NSURL URLWithString:[VFUtils getStringFromPlist:@"urlStore"]];
    [[UIApplication sharedApplication] openURL:url];

    
}
- (IBAction)goToListenBook:(id)sender {
    int tag = (int)[sender tag];
    AudioBookViewController *audioBook = [[AudioBookViewController alloc] initWithNibName:@"AudioBookViewController" bundle:nil tag:tag];
    [self.navigationController pushViewController:audioBook animated:YES];
    
}

@end
