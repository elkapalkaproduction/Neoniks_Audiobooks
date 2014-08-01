//
//  ChartboostDelegates.h
//  audiobooks
//
//  Created by Andrei Vidrasco on 3/24/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chartboost.h"
@interface ChartboostDelegates : NSObject <ChartboostDelegate>
+ (id)sharedManager;
@end
