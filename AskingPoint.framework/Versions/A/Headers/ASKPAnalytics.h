//
//  ASKPAnalytics.h
//  AskingPoint
//
//  Copyright (c) 2012 KnowFu Inc. All rights reserved.
//
#import <AskingPoint/ASKPContext.h>

ASKINGPOINT_EXTERN NSString * const ASKPUserGender;   // @"M" or @"F"
ASKINGPOINT_EXTERN NSString * const ASKPUserAge;
ASKINGPOINT_EXTERN NSString * const ASKPUserLocation; // CLLocation

typedef enum ASKPEventType {
    ASKPEventStartup      = 1,
    ASKPEventShutdown     = 2,
    ASKPEventEnvironment  = 3,
    ASKPEventCustom       = 4,
    ASKPEventUserData     = 7, // User info: age, gender, location
    ASKPEventCommand      = 8, // Events triggered by user actions on a command (eg. webview)
    ASKPEventCustomStart  = 9,
    ASKPEventCustomStop   = 10,
    ASKPEventTagRequest   = 11,
    ASKPEventRegisterPush = 12,
    ASKPEventOpenedPush   = 13,
    ASKPEventAdImpression = 14,
    ASKPEventAdClick      = 15,
    ASKPEventAdStatus     = 16,
} ASKPEventType;

@interface ASKPAnalyticsEvent : NSObject
@property(nonatomic,readonly) ASKPEventType type;
@property(nonatomic,readonly) NSString *name;
@property(nonatomic,readonly) NSDictionary *data;

+(id)eventWithName:(NSString*)name;
+(id)eventWithName:(NSString *)name andData:(NSDictionary*)data;

// Dictionary with ASKPUser* fields
+(id)eventWithUserData:(NSDictionary*)userData;

@end

// Timed event start event. Call stopEvent to create a matching stop event.
@interface ASKPAnalyticsTimedStartEvent : ASKPAnalyticsEvent
@property(nonatomic,readonly) NSString *timedEventId;

-(ASKPAnalyticsEvent*)stopEvent;
-(ASKPAnalyticsEvent*)stopEventWithData:(NSDictionary*)data;

@end

@protocol ASKPAnalyticsDelegate <NSObject>
@optional
- (void)analytics:(ASKPAnalytics*)analytics willSendEvent:(ASKPAnalyticsEvent*)event;
@end

@interface ASKPAnalytics : NSObject

@property(nonatomic) BOOL optedOut;
@property(nonatomic) BOOL pushEnabled;
@property(nonatomic,assign) id<ASKPAnalyticsDelegate> delegate;

-(void)addEvent:(ASKPAnalyticsEvent *)event;
-(void)sendIfNeeded;

@end

#ifndef __ASKINGPOINT_NO_COMPAT
@compatibility_alias APAnalytics ASKPAnalytics;

@compatibility_alias APEvent ASKPAnalyticsEvent;
@compatibility_alias APAnalyticsEvent ASKPAnalyticsEvent;
@compatibility_alias APTimedStartEvent ASKPAnalyticsTimedStartEvent;
@compatibility_alias APAnalyticsTimedStartEvent ASKPAnalyticsTimedStartEvent;
#endif
