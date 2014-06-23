//
//  VFAdMobSingleton.h
//  audiobooks
//
//  Created by Andrei Vidrasco on 3/24/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADBannerView.h"
#import "Flurry.h"
#import "Apsalar.h"
#define AdMobAdUnitID @"ca-app-pub-1480731978958686/8812608195"

#define FlurryKey @"PNHV8MQ6V8DMKB5244SV"

#define AppSalarKey @"elkapalkaproduction"
#define AppSalarSecret @"HNavyRmD"

#define ChartboostAppID @"532fcf089ddc356bc3332acd"
#define ChartboostAppSignature @"ad60c4b1249d7467caad02fa1047cc7236070118"

#define AdColonyAppID @"app51af74a4517d4511b2"
#define AdColonyOnStartZone @"vzdf9f9b654d24424fa5"

#define RevMobKey @"532fd204e7e5d4be2c067e88"


@interface VFAdsSingleton : NSObject
@property (strong, nonatomic) GADBannerView *bannerView;
+ (id)sharedManager;
-(void)setAdMobTo:(id)viewC;
+(void)saveAnalytics:(NSString *)event;
@end
