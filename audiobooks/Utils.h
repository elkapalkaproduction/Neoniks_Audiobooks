//
//  Utils.h
//  Neoniks
//
//  Created by Andrei Vidrasco on 2/12/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//
#import <Foundation/Foundation.h>
///AudioBooks
#define guestTitle  @"unwelcome_guest"//tag1
#define cakeTitle  @"giant_cake" //tag2
#define waterTitle @"enchanted_water"//tag3
#define carnivalTitle @"sea_carnival"//tag4
#define parcelTitle @"strange_parcel"//tag5
#define fountainTitle @"performance"//tag6

////------////





#define kLanguage @"PreferedLanguage"
#define kRussianLanguageTag @"ru"
#define kEnglishLanguageTag @"en"

#define kRussian [[[NSUserDefaults standardUserDefaults] objectForKey:kLanguage] isEqualToString:kRussianLanguageTag]
#define kEnglish [[[NSUserDefaults standardUserDefaults] objectForKey:kLanguage] isEqualToString:kEnglishLanguageTag]

#define kSetEnglish [[NSUserDefaults standardUserDefaults] setObject:kEnglishLanguageTag forKey:kLanguage];
#define kSetRussian [[NSUserDefaults standardUserDefaults] setObject:kRussianLanguageTag forKey:kLanguage];

#define IS_PHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#define IS_PHONE5 [UIScreen mainScreen].bounds.size.height == 568

#define IS_PHONE4 [UIScreen mainScreen].bounds.size.height != 568 && IS_PHONE

#define AVLocalizedSystem(string) [NSString stringWithFormat:@"%@_%@",string,kRussian? @"rus":@"eng"]

#define kAnimationDuration 1
#define kAnimationHide kAnimationDuration/1.9

@interface Utils : NSObject
+(UIImage *)imageWithName:(NSString *)name;
+(UIButton *)buttonWithFrame:(CGRect)rect tag:(int)tag image:(UIImage *)image target:(id)target selector:(SEL)selector;
@end
