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
@interface AudioBookViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *coverImage;
@property (strong, nonatomic) IBOutlet UIImageView *mainTitleImage;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIButton *languageButton;
@property (assign, nonatomic) int numberOfTale;

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
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(NSString *)getTitle{
    switch (_numberOfTale) {
        case 1:
            return guestTitle;
            break;
        case 2:
            return cakeTitle;
            break;
        case 3:
            return waterTitle;
            break;
        case 4:
            return carnivalTitle;
            break;
        case 5:
            return parcelTitle;
            break;
        case 6:
            return fountainTitle;
            break;
        default:
            return @"";
            break;
    }
}
-(void)updateLanguage{
    _descriptionTextView.text = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(@"texts") ofType:@"plist"]] objectForKey:[NSString stringWithFormat:@"%d",_numberOfTale]];
    [_mainTitleImage setImage:[Utils imageWithName:@"magic_fairy_tales"]];
    [_coverImage setImage:[Utils imageWithName:[self getTitle]]];
    [_languageButton setBackgroundImage:[Utils imageWithName:@"language"] forState:UIControlStateNormal];
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

@end
