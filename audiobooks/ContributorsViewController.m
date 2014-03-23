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
-(void)changeYPos:(int)y forItem:(id)item{
    [item setFrame:CGRectMake([item frame].origin.x, y, [item frame].size.width, [item frame].size.height)];
}
- (IBAction)goToContentList:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    if (IS_PHONE4) {
        [self changeYPos:146 forItem:_descriptionTextView];
        [self changeYPos:260 forItem:_giftButton];
        [self changeYPos:350 forItem:_authorsTextView];
        
    }
    
    [super viewWillAppear:animated];
    [self updateLanguage];
}
- (void)viewDidLoad
{
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
    [_giftButton setBackgroundImage:[Utils imageWithName:@"gift"] forState:UIControlStateNormal];
    [_mainTitleImage setImage:[Utils imageWithName:@"magic_fairy_tales"]];
    [_languageButton setImage:[Utils imageWithName:@"language"] forState:UIControlStateNormal];
}
- (IBAction)goToRateOnStore:(id)sender {
    NSURL *url = [NSURL URLWithString:[Utils getStringFromPlist:@"urlStore"]];
    [[UIApplication sharedApplication] openURL:url];
    
    
}
- (IBAction)goToNeoniki:(id)sender {
    NSURL *url = [NSURL URLWithString:[Utils getStringFromPlist:@"urlNeoniki"]];
    [[UIApplication sharedApplication] openURL:url];
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

@end
