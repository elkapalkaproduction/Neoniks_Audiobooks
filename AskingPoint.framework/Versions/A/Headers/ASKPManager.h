//
//  ASKPManager.h
//  AskingPoint
//
//  Copyright (c) 2012 KnowFu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AskingPoint/ASKPCommand.h>

@class CLLocation;

// Return YES if the command was processed, NO to use the default handler
typedef BOOL (^ASKPManagerCommandHandler)(ASKPCommand *command);
typedef void (^ASKPManagerAlertResponse)(ASKPCommand *command, ASKPAlertButton *pressed);
typedef BOOL (^ASKPManagerTagRequestComplete)(NSString *tag, ASKPCommand *command);

@interface ASKPManager : NSObject

// System root view controller
// defaults to [[[UIApplication sharedApplication] keyWindow] rootViewController]
@property(nonatomic,retain) UIViewController *rootViewController;

@property(nonatomic,copy) ASKPManagerCommandHandler commandHandler;
@property(nonatomic,copy) ASKPManagerAlertResponse alertResponse;

+(ASKPManager *)sharedManager;
+(void)startup:(NSString *)apiKey;
+(void)setLocalizedAppName:(NSString*)localizedAppName;
+(NSString*)localizedAppName;

+(void)setAppVersion:(NSString*)appVersion;

+(void)addEventWithName:(NSString *)name;
+(void)addEventWithName:(NSString *)name andData:(NSDictionary *)data;

+(void)startTimedEventWithName:(NSString *)name;
+(void)startTimedEventWithName:(NSString *)name andData:(NSDictionary *)data;
+(void)stopTimedEventWithName:(NSString *)name;
+(void)stopTimedEventWithName:(NSString *)name andData:(NSDictionary *)data;

+(void)requestCommandsWithTag:(NSString*)tag;
+(void)requestCommandsWithTag:(NSString *)tag completionHandler:(ASKPManagerTagRequestComplete)completionHandler;
+(void)reportAlertResponseForCommand:(ASKPCommand*)command button:(ASKPAlertButton*)pressed;

+(void)setGender:(NSString *)gender;     // @"M" or @"F"
+(void)setAge:(int)age;
+(void)setLocation:(CLLocation *)location;

+(void)sendIfNeeded;

+(void)setOptedOut:(BOOL)optedOut;
+(BOOL)optedOut;

// System root view controller
// defaults to [[[UIApplication sharedApplication] keyWindow] rootViewController]
+(void)setRootViewController:(UIViewController*)rootViewController;

@end


#ifndef __ASKINGPOINT_NO_COMPAT

@compatibility_alias APManager ASKPManager;

typedef ASKPManagerCommandHandler APManagerCommandHandler __attribute__ ((deprecated("Use ASKPManagerCommandHandler")));
typedef ASKPManagerAlertResponse APManagerAlertResponse __attribute__ ((deprecated("Use ASKPManagerAlertResponse")));
typedef ASKPManagerTagRequestComplete APManagerTagRequestComplete __attribute__ ((deprecated("Use ASKPManagerTagRequestComplete")));

#endif