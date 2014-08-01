//
//  AudioBookViewController.m
//  audiobooks
//
//  Created by Andrei Vidrasco on 3/21/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "AudioBookViewController.h"
#import "VFUtils.h"
#import "ContributorsViewController.h"
#import "AudioPlayer.h"
#import "MKStoreManager.h"
#import "SVProgressHUD.h"
#import <AdColony/AdColony.h>
#import "GADInterstitial.h"

@interface AudioBookViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int numberOfTale;

@property (strong, nonatomic) IBOutlet UIImageView *coverImage;
@property (strong, nonatomic) IBOutlet UIImageView *mainTitleImage;
@property (strong, nonatomic) IBOutlet UIImageView *soundMinus;
@property (strong, nonatomic) IBOutlet UIImageView *soundPlus;

@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (strong, nonatomic) IBOutlet UIButton *languageButton;

@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UISlider *timeSlider;
@property (strong, nonatomic) IBOutlet UISlider *volumeSlider;

@property (strong, nonatomic) IBOutlet UIButton *buyThisBook;
@property (strong, nonatomic) IBOutlet UIButton *restoreThisBook;
@property (strong, nonatomic) IBOutlet UIButton *buyAllBook;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (strong, nonatomic) GADInterstitial *interstitial;

@end

@implementation AudioBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil tag:(int)tag
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _numberOfTale = tag;
        // Custom initialization
    }
    return self;
}
- (IBAction)goToContentList:(id)sender {
    NSLog(@"Home button is clicked");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    if (IS_PHONE4) {
        [VFUtils changeYPos:388 forItem:_restoreThisBook];
        [VFUtils changeYPos:388 forItem:_buyThisBook];
        [VFUtils changeYPos:325 forItem:_endTimeLabel];
        [VFUtils changeYPos:325 forItem:_currentTimeLabel];
        [VFUtils changeYPos:355 forItem:_playButton];
        [VFUtils changeYPos:320 forItem:_timeSlider];
        _descriptionTextView.frame = CGRectMake(_descriptionTextView.frame.origin.x, _descriptionTextView.frame.origin.y, _descriptionTextView.frame.size.width, 60);
        
    }
    [super viewWillAppear:animated];
    NSString *string =[NSString stringWithFormat:@"%@_is_shown",[VFUtils getTitle:_numberOfTale]];
    [VFAdsSingleton saveAnalytics:AVLocalizedSystem(string)];
    [self updateLanguage];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"alertClicked" object:nil];
}
- (void)viewDidLoad
{
    [[VFAdsSingleton sharedManager] setAdMobTo:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLanguage) name:@"alertClicked" object:nil];
    [super viewDidLoad];
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = AdMobOnPressNo;
    [self.interstitial loadRequest:[GADRequest request]];

    // Do any additional setup after loading the view from its nib.
}

-(void)updateLanguage{
    
     _playButton.hidden = ![VFUtils isPurcahed:_numberOfTale];
    
    _buyThisBook.hidden = [VFUtils isPurcahed:_numberOfTale];
    _restoreThisBook.hidden = [VFUtils isPurcahed:_numberOfTale];
    _buyAllBook.hidden = [VFUtils isPurcahed:_numberOfTale];
    
    
    
    _descriptionTextView.text = [VFUtils getStringFromPlist:[NSString stringWithFormat:@"%d",_numberOfTale]];
    [_buyThisBook setTitle:[VFUtils getStringFromPlist:@"buyThisBook"] forState:UIControlStateNormal];
    [_restoreThisBook setTitle:[VFUtils getStringFromPlist:@"restore"] forState:UIControlStateNormal];
    [_mainTitleImage setImage:[VFUtils imageWithName:@"magic_fairy_tales"]];
    [_coverImage setImage:[VFUtils imageWithName:[VFUtils getTitle:_numberOfTale]]];
    [_buyAllBook setBackgroundImage:[VFUtils imageWithName:@"sale"] forState:UIControlStateNormal];
    [_languageButton setBackgroundImage:[VFUtils imageWithName:@"language"] forState:UIControlStateNormal];
    _volumeSlider.value = [[AudioPlayer sharedManager] audioPlayer].volume;
    if (_numberOfTale == [[AudioPlayer sharedManager] currentTrack] && [[[AudioPlayer sharedManager] audioPlayer] isPlaying]) {
        [_playButton setBackgroundImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
        _timeSlider.hidden = _currentTimeLabel.hidden = _endTimeLabel.hidden = _soundMinus.hidden = _soundPlus.hidden = _volumeSlider.hidden = NO;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
    } else {
        if (_numberOfTale == [[AudioPlayer sharedManager] currentTrack]){
            [self updateSlider];
        } else {
            _timeSlider.value = 0.f;
        }
        [_timer invalidate];
        _timeSlider.hidden = _currentTimeLabel.hidden = _endTimeLabel.hidden = _soundMinus.hidden = _soundPlus.hidden = _volumeSlider.hidden = YES;

        [_playButton setBackgroundImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];

    }
}
-(void)updateSlider{
    _currentTimeLabel.text = [VFUtils getTimeForSeconds:[[[AudioPlayer sharedManager] audioPlayer] currentTime]];
    _endTimeLabel.text = [VFUtils getTimeForSeconds:[[[AudioPlayer sharedManager] audioPlayer] duration]];
    
    _timeSlider.value = [[[AudioPlayer sharedManager] audioPlayer]currentTime]/[[[AudioPlayer sharedManager] audioPlayer] duration];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)changeBook:(id)sender {
    NSRange range = NSMakeRange(1, 1);
    [_descriptionTextView scrollRangeToVisible:range];
    
    _numberOfTale += [sender tag];
    if (_numberOfTale == 0) {
        _numberOfTale = 6;
    } else if (_numberOfTale == 7){
        _numberOfTale = 1;
    }
    NSString *string =[NSString stringWithFormat:@"%@_is_shown",[VFUtils getTitle:_numberOfTale]];
    [VFAdsSingleton saveAnalytics:AVLocalizedSystem(string)];
    [self updateLanguage];
}
- (IBAction)play:(id)sender {
    [[AudioPlayer sharedManager] playBook:_numberOfTale];
    if (_numberOfTale == [[AudioPlayer sharedManager] currentTrack] && [[[AudioPlayer sharedManager] audioPlayer] isPlaying]) {
        _timeSlider.hidden = _currentTimeLabel.hidden = _endTimeLabel.hidden = _soundMinus.hidden = _soundPlus.hidden = _volumeSlider.hidden = NO;
        NSString *string =[NSString stringWithFormat:@"%@_is_playing",[VFUtils getTitle:_numberOfTale]];
        [VFAdsSingleton saveAnalytics:AVLocalizedSystem(string)];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];

    } else {
        [_timer invalidate];
        _timeSlider.hidden = _currentTimeLabel.hidden = _endTimeLabel.hidden = _soundMinus.hidden = _soundPlus.hidden = _volumeSlider.hidden = YES;
        
        [_playButton setBackgroundImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
        
    }
}
- (IBAction)timeSlider:(id)sender {
    [[[AudioPlayer sharedManager] audioPlayer]setCurrentTime:_timeSlider.value*[[[AudioPlayer sharedManager] audioPlayer] duration]];
    
}
- (IBAction)volumeSlider:(id)sender {
    [[[AudioPlayer sharedManager] audioPlayer] setVolume:_volumeSlider.value];
}

#pragma mark - 
#pragma mark - Buying Books

- (IBAction)buyThisBook:(id)sender {
    NSString *productID = [VFUtils getPurchased:_numberOfTale];
    [SVProgressHUD show];
    NSString *string =[NSString stringWithFormat:@"clicked_in_app_in_%@",[VFUtils getTitle:_numberOfTale]];
    [VFAdsSingleton saveAnalytics:AVLocalizedSystem(string)];

    [[MKStoreManager sharedManager] buyFeature:productID onComplete:^(NSString* purchasedFeature, NSData *purchasedReceipt)
     {
         [SVProgressHUD dismiss];
         [self updateLanguage];
         NSString *string =[NSString stringWithFormat:@"bought_in_app_in_%@",[VFUtils getTitle:_numberOfTale]];
         [VFAdsSingleton saveAnalytics:AVLocalizedSystem(string)];
         NSLog(@"Purchased: %@", purchasedFeature);
     }
                                   onCancelled:^
     {
         [SVProgressHUD dismiss];
         [self updateLanguage];

         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[VFUtils getStringFromPlist:@"Purchase Stopped"] message:[VFUtils getStringFromPlist:@"message1"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         alert.tag = 1;
         [alert show];
         
     }];

}
- (IBAction)restoreThisBook:(id)sender {
    [SVProgressHUD show];
    [[MKStoreManager sharedManager] restorePreviousTransactionsOnComplete:^{
        [SVProgressHUD dismiss];
        [self updateLanguage];
    } onError:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self updateLanguage];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[VFUtils getStringFromPlist:@"Error"] message:[VFUtils getStringFromPlist:@"message2"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 1;
        [alert show];
        
    }];
}
- (IBAction)buyAllBook:(id)sender {
    NSString *productID = [VFUtils getPurchased:0];
    
    NSString *string =[NSString stringWithFormat:@"clicked_sale_in_%@",[VFUtils getTitle:_numberOfTale]];
    [VFAdsSingleton saveAnalytics:AVLocalizedSystem(string)];

    [SVProgressHUD show];
    [[MKStoreManager sharedManager] buyFeature:productID onComplete:^(NSString* purchasedFeature, NSData *purchasedReceipt)
     {
         [SVProgressHUD dismiss];
         [self updateLanguage];
         NSString *string =[NSString stringWithFormat:@"bought_sale_in_%@",[VFUtils getTitle:_numberOfTale]];
         [VFAdsSingleton saveAnalytics:AVLocalizedSystem(string)];

         NSLog(@"Purchased: %@", purchasedFeature);
     }
                                   onCancelled:^
     {
         [SVProgressHUD dismiss];
         [self updateLanguage];
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[VFUtils getStringFromPlist:@"Purchase Stopped"] message:[VFUtils getStringFromPlist:@"message1"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         alert.tag = 1;
         [alert show];
         
     }];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if ([AdColony zoneStatusForZone:AdColonyOnPressNo] == ADCOLONY_ZONE_STATUS_ACTIVE) {
            [AdColony playVideoAdForZone:AdColonyOnPressNo withDelegate:nil];
        } else {
            [self.interstitial presentFromRootViewController:self];
        }

//        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"" message:[VFUtils getStringFromPlist:@"freeGameOffer"] delegate:self cancelButtonTitle:[VFUtils getStringFromPlist:@"No"] otherButtonTitles:[VFUtils getStringFromPlist:@"Yes"], nil];
//        alert.tag = 2;
//        [alert show];
    }
    if (alertView.tag == 2) {
//        if (buttonIndex == 1) {
//            NSString *string =[NSString stringWithFormat:@"user_press_RevMobsYes_in_%@",[VFUtils getTitle:_numberOfTale]];
//            [VFAdsSingleton saveAnalytics:AVLocalizedSystem(string)];
//        } else {
//            NSString *string =[NSString stringWithFormat:@"user_press_RevMobsYes_in_%@",[VFUtils getTitle:_numberOfTale]];
//            [VFAdsSingleton saveAnalytics:AVLocalizedSystem(string)];
//
//        }
    }
    
}
-(void)revmobAdDidFailWithError:(NSError *)error{
}
@end
