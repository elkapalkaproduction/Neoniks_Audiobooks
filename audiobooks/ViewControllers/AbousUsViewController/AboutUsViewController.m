//
//  AboutUsViewController.m
//  audiobooks
//
//  Created by Andrei Vidrasco on 6/18/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *textImage;
@property (strong, nonatomic) IBOutlet UIImageView *textImageIpad;
@property (strong, nonatomic) IBOutlet UIButton *siteIpad;
@property (strong, nonatomic) IBOutlet UIButton *site;

@end

@implementation AboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }

    return self;
}


- (void)viewDidLoad {
    self.textImage.image = [VFUtils imageWithName:@"640_tex"];
    self.textImageIpad.image = [VFUtils imageWithName:@"1536_tex"];
    [self.site setImage:[VFUtils imageWithName:@"page2_site"] forState:UIControlStateNormal];
    [self.siteIpad setImage:[VFUtils imageWithName:@"site"] forState:UIControlStateNormal];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dissmisViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)openSite:(id)sender {
    NSURL *url = [NSURL URLWithString:[VFUtils getStringFromPlist:@"urlNeoniki"]];
    [[UIApplication sharedApplication] openURL:url];
}


@end
