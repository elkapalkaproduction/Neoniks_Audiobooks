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
@interface AudioBookViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *coverImage;
@property (strong, nonatomic) IBOutlet UIImageView *mainTitleImage;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIButton *languageButton;
@property (assign, nonatomic) int numberOfTale;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UISlider *timeSlider;
@property (strong, nonatomic) IBOutlet UISlider *volumeSlider;
@property (strong, nonatomic) NSTimer *timer;
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
    _descriptionTextView.text = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(@"texts") ofType:@"plist"]] objectForKey:[NSString stringWithFormat:@"%d",_numberOfTale]];
    [_mainTitleImage setImage:[Utils imageWithName:@"magic_fairy_tales"]];
    [_coverImage setImage:[Utils imageWithName:[Utils getTitle:_numberOfTale]]];
    [_languageButton setBackgroundImage:[Utils imageWithName:@"language"] forState:UIControlStateNormal];
    _volumeSlider.value = [[AudioPlayer sharedManager] audioPlayer].volume;
    if (_numberOfTale == [[AudioPlayer sharedManager] currentTrack] && [[[AudioPlayer sharedManager] audioPlayer] isPlaying]) {
        [_playButton setTitle:@"Pause" forState:UIControlStateNormal];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
    } else {
        if (_numberOfTale == [[AudioPlayer sharedManager] currentTrack]){
            [self updateSlider];
        } else {
            _timeSlider.value = 0.f;
        }
        [_timer invalidate];
        [_playButton setTitle:@"Play" forState:UIControlStateNormal];

    }
}
-(void)updateSlider{
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
        [_playButton setTitle:@"Pause" forState:UIControlStateNormal];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];

    } else {
        [_timer invalidate];
        [_playButton setTitle:@"Play" forState:UIControlStateNormal];
        
    }
}
- (IBAction)timeSlider:(id)sender {
    [[[AudioPlayer sharedManager] audioPlayer]setCurrentTime:_timeSlider.value*[[[AudioPlayer sharedManager] audioPlayer] duration]];
    
}
- (IBAction)volumeSlider:(id)sender {
    [[[AudioPlayer sharedManager] audioPlayer] setVolume:_volumeSlider.value];
}

@end
