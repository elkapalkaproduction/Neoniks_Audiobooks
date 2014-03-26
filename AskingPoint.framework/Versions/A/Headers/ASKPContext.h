//
//  ASKPContext.h
//  AskingPoint
//
//  Copyright (c) 2012 KnowFu Inc. All rights reserved.
//
#import <Foundation/Foundation.h>

#define ASKP_VERSION @"3.0.3"
extern NSString * const ASKPVersion;

#define ASKP_COPYRIGHT @"AskingPoint SDK v" ASKP_VERSION @". Copyright 2012-2014 KnowFu Inc., All Rights Reserved."

#if defined(__cplusplus)
#define ASKINGPOINT_EXTERN extern "C"
#else
#define ASKINGPOINT_EXTERN extern
#endif

extern const int ASKPLogLevelError;
extern const int ASKPLogLevelWarn;
extern const int ASKPLogLevelInfo;

@class ASKPAnalytics;
@class ASKPCommandManager;

@interface ASKPContext : NSObject

@property(nonatomic,copy) NSString *localizedAppName;
@property(nonatomic,copy) NSString *appVersion;

+(void)startup:(NSString *)appKey;
+(ASKPContext *)sharedContext;

+(void)setLogLevel:(int)logLevel;

@end

@interface ASKPContext (ASKPAnalytics)
@property(nonatomic,readonly) ASKPAnalytics *analytics;
+(ASKPAnalytics *)sharedAnalytics;
@end

@interface ASKPContext (ASKPCommandManager)
@property(nonatomic,readonly) ASKPCommandManager *commandManager;
+(ASKPCommandManager *)sharedCommandManager;
@end

#ifndef __ASKINGPOINT_NO_COMPAT
@compatibility_alias APContext ASKPContext;
#endif