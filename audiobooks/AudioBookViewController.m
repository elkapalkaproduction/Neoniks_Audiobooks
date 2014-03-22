//
//  AudioBookViewController.m
//  audiobooks
//
//  Created by Andrei Vidrasco on 3/21/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "AudioBookViewController.h"
#import "Utils.h"
#import "ContributorsViewController.h"
#import "AudioPlayer.h"
#import "MKStoreManager.h"
#import "SVProgressHUD.h"
@interface AudioBookViewController ()
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    if (IS_PHONE4) {
        [Utils changeYPos:388 forItem:_restoreThisBook];
        [Utils changeYPos:388 forItem:_buyThisBook];
        [Utils changeYPos:325 forItem:_endTimeLabel];
        [Utils changeYPos:325 forItem:_currentTimeLabel];
        [Utils changeYPos:355 forItem:_playButton];
        [Utils changeYPos:320 forItem:_timeSlider];
        _descriptionTextView.frame = CGRectMake(_descriptionTextView.frame.origin.x, _descriptionTextView.frame.origin.y, _descriptionTextView.frame.size.width, 60);
        
    }
    [super viewWillAppear:animated];

    [self updateLanguage];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"alertClicked" object:nil];
}
- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLanguage) name:@"alertClicked" object:nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)updateLanguage{
    
     _playButton.hidden = _timeSlider.hidden = _currentTimeLabel.hidden = _endTimeLabel.hidden = _soundMinus.hidden = _soundPlus.hidden = _volumeSlider.hidden = ![Utils isPurcahed:_numberOfTale];
    
    _buyThisBook.hidden = [Utils isPurcahed:_numberOfTale];
    _restoreThisBook.hidden = [Utils isPurcahed:_numberOfTale];
    _buyAllBook.hidden = [Utils isPurcahed:_numberOfTale];
    
    
    
    _descriptionTextView.text = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(@"texts") ofType:@"plist"]] objectForKey:[NSString stringWithFormat:@"%d",_numberOfTale]];
    [_mainTitleImage setImage:[Utils imageWithName:@"magic_fairy_tales"]];
    [_coverImage setImage:[Utils imageWithName:[Utils getTitle:_numberOfTale]]];
    [_buyAllBook setBackgroundImage:[Utils imageWithName:@"sale"] forState:UIControlStateNormal];
    [_languageButton setBackgroundImage:[Utils imageWithName:@"language"] forState:UIControlStateNormal];
    _volumeSlider.value = [[AudioPlayer sharedManager] audioPlayer].volume;
    if (_numberOfTale == [[AudioPlayer sharedManager] currentTrack] && [[[AudioPlayer sharedManager] audioPlayer] isPlaying]) {
        [_playButton setBackgroundImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
    } else {
        if (_numberOfTale == [[AudioPlayer sharedManager] currentTrack]){
            [self updateSlider];
        } else {
            _timeSlider.value = 0.f;
        }
        [_timer invalidate];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];

    }
}
-(void)updateSlider{
    _currentTimeLabel.text = [Utils getTimeForSeconds:[[[AudioPlayer sharedManager] audioPlayer] currentTime]];
    _endTimeLabel.text = [Utils getTimeForSeconds:[[[AudioPlayer sharedManager] audioPlayer] duration]];
    
    _timeSlider.value = [[[AudioPlayer sharedManager] audioPlayer]currentTime]/[[[AudioPlayer sharedManager] audioPlayer] duration];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goToContributors:(id)sender {
    ContributorsViewController *audioBook = [[ContributorsViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:audioBook animated:YES];
    
}

- (IBAction)changeLanguage:(id)sender {
    [[AudioPlayer sharedManager] stop];
    if (kRussian) {
        kSetEnglish;
    } else {
        kSetRussian;
    }
    [self updateLanguage];
}
- (IBAction)changeBook:(id)sender {
    _numberOfTale += [sender tag];
    if (_numberOfTale == 0) {
        _numberOfTale = 6;
    } else if (_numberOfTale == 7){
        _numberOfTale = 1;
    }
    [self updateLanguage];
}
- (IBAction)play:(id)sender {
    [[AudioPlayer sharedManager] playBook:_numberOfTale];
    if (_numberOfTale == [[AudioPlayer sharedManager] currentTrack] && [[[AudioPlayer sharedManager] audioPlayer] isPlaying]) {
        [_playButton setBackgroundImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];

    } else {
        [_timer invalidate];
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
    NSString *productID = [Utils getPurchased:_numberOfTale];
    [SVProgressHUD show];
    [[MKStoreManager sharedManager] buyFeature:productID onComplete:^(NSString* purchasedFeature, NSData *purchasedReceipt)
     {
         [SVProgressHUD dismiss];
         [self updateLanguage];
         NSLog(@"Purchased: %@", purchasedFeature);
     }
                                   onCancelled:^
     {
         [SVProgressHUD dismiss];
         [self updateLanguage];

         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(@"texts") ofType:@"plist"]] objectForKey:@"Purchase Stopped"] message:[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(@"texts") ofType:@"plist"]] objectForKey:@"message1"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(@"texts") ofType:@"plist"]] objectForKey:@"Error"] message:[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(@"texts") ofType:@"plist"]] objectForKey:@"message2"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }];
}
- (IBAction)buyAllBook:(id)sender {
    NSString *productID = [Utils getPurchased:0];
    [SVProgressHUD show];
    [[MKStoreManager sharedManager] buyFeature:productID onComplete:^(NSString* purchasedFeature, NSData *purchasedReceipt)
     {
         [SVProgressHUD dismiss];
         [self updateLanguage];
         NSLog(@"Purchased: %@", purchasedFeature);
     }
                                   onCancelled:^
     {
         [SVProgressHUD dismiss];
         [self updateLanguage];
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(@"texts") ofType:@"plist"]] objectForKey:@"Purchase Stopped"] message:[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(@"texts") ofType:@"plist"]] objectForKey:@"message1"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         
         [alert show];
         
     }];

}


@end
