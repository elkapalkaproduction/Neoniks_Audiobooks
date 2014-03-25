//
//  ContributorsViewController.m
//  audiobooks
//
//  Created by Andrei Vidrasco on 3/21/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "ContributorsViewController.h"
#import "AudioPlayer.h"
@interface ContributorsViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *mainTitleImage;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UITextView *authorsTextView;
@property (strong, nonatomic) IBOutlet UIButton *languageButton;
@property (strong, nonatomic) IBOutlet UIButton *giftButton;
@end

@implementation ContributorsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)goToContentList:(id)sender {
     [VFAdsSingleton saveAnalytics:@"Home button is clicked"];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    if (IS_PHONE4) {
        [VFUtils changeYPos:146 forItem:_descriptionTextView];
        [VFUtils changeYPos:260 forItem:_giftButton];
        [VFUtils changeYPos:350 forItem:_authorsTextView];
        
    }
    
    [super viewWillAppear:animated];
    [self updateLanguage];
}
- (void)viewDidLoad
{
    [[VFAdsSingleton sharedManager] setAdMobTo:self];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateLanguage{
    _descriptionTextView.text = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(@"texts") ofType:@"plist"]] objectForKey:[NSString stringWithFormat:@"%d",7]];
    _authorsTextView.text = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(@"texts") ofType:@"plist"]] objectForKey:[NSString stringWithFormat:@"%d",8]];
    [_giftButton setBackgroundImage:[VFUtils imageWithName:@"gift"] forState:UIControlStateNormal];
    [_mainTitleImage setImage:[VFUtils imageWithName:@"magic_fairy_tales"]];
    [_languageButton setImage:[VFUtils imageWithName:@"language"] forState:UIControlStateNormal];
}
- (IBAction)goToRateOnStore:(id)sender {
    NSURL *url = [NSURL URLWithString:[VFUtils getStringFromPlist:@"urlStore"]];
    [[UIApplication sharedApplication] openURL:url];
    
    
}
- (IBAction)goToNeoniki:(id)sender {
    [VFAdsSingleton saveAnalytics:@"Middle button in Contributors is clicked"];
    NSURL *url = [NSURL URLWithString:[VFUtils getStringFromPlist:@"urlNeoniki"]];
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

@end
