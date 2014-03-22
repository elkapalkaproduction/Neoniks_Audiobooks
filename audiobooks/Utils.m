//
//  Utils.m
//  Neoniks
//
//  Created by Andrei Vidrasco on 2/12/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "Utils.h"
#import "MKStoreManager.h"
@implementation Utils
+(UIImage *)imageWithName:(NSString *)name{
   return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:AVLocalizedSystem(name) ofType:@"png"]];
}
+(UIButton *)buttonWithFrame:(CGRect)rect tag:(int)tag image:(UIImage *)image target:(id)target selector:(SEL)selector{
    UIButton *button =[[UIButton alloc] initWithFrame:rect];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTag:tag];
    return button;
}
+(NSString *)getTitle:(int)tag{
    switch (tag) {
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
+(NSString *)getPurchased:(int)tag{
    switch (tag) {
        case 1:
            return guestInApp;
            break;
        case 2:
            return cakeInApp;
            break;
        case 3:
            return waterInApp;
            break;
        case 4:
            return carnivalInApp;
            break;
        case 5:
            return parcelInApp;
            break;
        case 6:
            return fountainInApp;
            break;
        default:
            return allInApp;
            break;
    }
}
+(BOOL)isPurcahed:(int)tag{
    NSString *featuredID = [Utils getPurchased:tag];
    
    BOOL isUnlockByDefault = [featuredID isEqualToString:cakeInApp];
    BOOL isUnlockedFeatured = [MKStoreManager isFeaturePurchased:featuredID];
    BOOL isUnlockedAll = [MKStoreManager isFeaturePurchased:allInApp];
    return isUnlockByDefault || isUnlockedFeatured || isUnlockedAll;
}
@end
