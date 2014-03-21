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
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *mainTitleImage;
@property (strong, nonatomic) IBOutlet UIButton *languageButton;
@property (strong, nonatomic) IBOutlet UIButton *guestCoverButton;
@property (strong, nonatomic) IBOutlet UIButton *cakeCoverButton;
@property (strong, nonatomic) IBOutlet UIButton *waterCoverButton;
@property (strong, nonatomic) IBOutlet UIButton *carnivalCoverButton;
@property (strong, nonatomic) IBOutlet UIButton *parcelCoverButton;
@property (strong, nonatomic) IBOutlet UIButton *fountainCoverButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)changeYPos:(int)y forItem:(id)item{
    [item setFrame:CGRectMake([item frame].origin.x, y, [item frame].size.width, [item frame].size.height)];
}
-(void)viewWillAppear:(BOOL)animated{
    if (IS_PHONE4) {
        [self changeYPos:158 forItem:_guestCoverButton];
        [self changeYPos:158 forItem:_cakeCoverButton];
        [self changeYPos:158 forItem:_waterCoverButton];
        
        [self changeYPos:296 forItem:_carnivalCoverButton];
        [self changeYPos:296 forItem:_parcelCoverButton];
        [self changeYPos:296 forItem:_fountainCoverButton];
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
    [_mainTitleImage setImage:[Utils imageWithName:@"magic_fairy_tales"]];
    [_languageButton setBackgroundImage:[Utils imageWithName:@"language"] forState:UIControlStateNormal];
    [_guestCoverButton setBackgroundImage:[Utils imageWithName:guestTitle] forState:UIControlStateNormal];
    [_cakeCoverButton setBackgroundImage:[Utils imageWithName:cakeTitle] forState:UIControlStateNormal];
    [_waterCoverButton setBackgroundImage:[Utils imageWithName:waterTitle] forState:UIControlStateNormal];
    [_carnivalCoverButton setBackgroundImage:[Utils imageWithName:carnivalTitle] forState:UIControlStateNormal];
    [_parcelCoverButton setBackgroundImage:[Utils imageWithName:parcelTitle] forState:UIControlStateNormal];
    [_fountainCoverButton setBackgroundImage:[Utils imageWithName:fountainTitle] forState:UIControlStateNormal];
}
- (IBAction)changeLanguage:(id)sender {
        if (kRussian) {
            kSetEnglish;
        } else {
            kSetRussian;
        }
        [self updateLanguage];
}
- (IBAction)goToContributors:(id)sender {
    ContributorsViewController *audioBook = [[ContributorsViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:audioBook animated:YES];

}
- (IBAction)goToRateOnStore:(id)sender {
    
}
- (IBAction)goToListenBook:(id)sender {
    AudioBookViewController *audioBook = [[AudioBookViewController alloc] initWithNibName:@"AudioBookViewController" bundle:nil tag:[sender tag]];
    [self.navigationController pushViewController:audioBook animated:YES];
    
}

@end
