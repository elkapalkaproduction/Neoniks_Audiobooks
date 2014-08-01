//
//  ASKPCommand.h
//  AskingPoint
//
//  Copyright (c) 2013 KnowFu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ASKPCommandType {
    ASKPCommandWeb,                   // Set for Pop-up WebView. E.g. survey
    ASKPCommandAlert,                 // Set for Messages, Rating Booster
    ASKPCommandPayload,               // Set for Remote-Control feature
    ASKPCommandInterstitial           // Set for ad interstitials
} ASKPCommandType;

typedef enum ASKPAlertType {
    ASKPAlertUnknown,                 // An UNKNOWN AlertType. Should not be seen by end user Apps
    ASKPAlertRating,                  // Ratings Booster
    ASKPAlertMessage                  // Pull Message
} ASKPAlertType;

typedef enum ASKPAlertRatingButtonType {
    ASKPAlertRatingNone,              // An ERROR. Not a Rating Alert Button
    ASKPAlertRatingYes,               // Will rate it
    ASKPAlertRatingNo,                // Will not rate it
    ASKPAlertRatingRemindMe           // Remind me to rate it later
} ASKPAlertRatingButtonType;

@interface ASKPCommand : NSObject
@property(nonatomic,readonly) ASKPCommandType type;
@property(nonatomic,readonly) id commandId;
@property(nonatomic,readonly) BOOL test;                // Set to YES when shown by a Dashboard Test.
@property(nonatomic,readonly) NSSet *tags;              // Lists Tags set in features Dashboard Tag Editor.
@property(nonatomic,readonly) NSString *requestedTag;   // Tag that triggered this.
@property(nonatomic,readonly) id data;                  // Contains JSON data when Remote-Control ASKPCommandPayload
@property(nonatomic,readonly,getter=isComplete) BOOL complete; // Indicates processing of an ASKPCommand is complete.
-(void)reportComplete;                                  // Must be called when done processing Remote-Control (Payload) or else no further commands are received.
@end

@interface ASKPCommand (Web)
@property(nonatomic,readonly) NSURL *url;               // URL the pop-up web view will take the user to.
@end

@class ASKPAlertButton;

@interface ASKPCommand (Alert)
@property(nonatomic,readonly) ASKPAlertType alertType;
@property(nonatomic,copy) NSString *language;           // BCP 47 Language code (wikipedia.org/wiki/BCP_47).
@property(nonatomic,copy) NSString *title;              // Text to show in widget title bar.
@property(nonatomic,copy) NSString *message;            // Text to show in widget message body.
@property(nonatomic,readonly) NSArray *buttons;         // Array of ASKPAlertButton items to show on widget.
-(void)reportCompleteWithButton:(ASKPAlertButton*)button; // Must be called when customizing Rating or Message widget look and feel and your widget is
                                                        // collecting button responses. This reports the user selection and prevents them being prompted again.
@end

@interface ASKPAlertButton : NSObject
@property(nonatomic,readonly) id buttonId;
@property(nonatomic,readonly) BOOL cancel;  // Follows Apple usability guidelines for Cancel buttons.
@property(nonatomic,readonly) NSURL *url;   // On Rating widget, the "Rate It" button contains a URL to the App's app store page. On a Message widget, Custom buttons have this set to URL added to button, else nil
@property(nonatomic,copy) NSString *text;   // Text that is shown on button, will be in language implied by ASKPCommand language property.
@end

@interface ASKPAlertButton (Rating)
@property(nonatomic,readonly) ASKPAlertRatingButtonType ratingType;
@end

#ifndef __ASKINGPOINT_NO_COMPAT

@compatibility_alias APCommand ASKPCommand; // Deprecated, use ASKPCommand
@compatibility_alias APAlertButton ASKPAlertButton; // Deprecated, use ASKPAlertButton

typedef ASKPCommandType APCommandType __attribute__ ((deprecated("Use ASKPCommandType")));
__attribute__ ((deprecated("Use ASKPCommandWeb"))) static const APCommandType APCommandWeb = ASKPCommandWeb;
__attribute__ ((deprecated("Use ASKPCommandAlert"))) static const APCommandType APCommandAlert = ASKPCommandAlert;
__attribute__ ((deprecated("Use ASKPCommandPayload"))) static const APCommandType APCommandPayload = ASKPCommandPayload;

typedef ASKPAlertType APAlertType __attribute__ ((deprecated("Use ASKPAlertType")));
__attribute__ ((deprecated("Use ASKPAlertUnknown"))) static const APAlertType APAlertUnknown = ASKPAlertUnknown;
__attribute__ ((deprecated("Use ASKPAlertRating"))) static const APAlertType APAlertRating = ASKPAlertRating;
__attribute__ ((deprecated("Use ASKPAlertMessage"))) static const APAlertType APAlertMessage = ASKPAlertMessage;

typedef ASKPAlertRatingButtonType APAlertRatingButtonType __attribute__ ((deprecated("Use ASKPAlertRatingButtonType")));
__attribute__ ((deprecated("Use ASKPAlertRatingNone"))) static const APAlertRatingButtonType APAlertRatingNone = ASKPAlertRatingNone;
__attribute__ ((deprecated("Use ASKPAlertRatingYes"))) static const APAlertRatingButtonType APAlertRatingYes = ASKPAlertRatingYes;
__attribute__ ((deprecated("Use ASKPAlertRatingNo"))) static const APAlertRatingButtonType APAlertRatingNo = ASKPAlertRatingNo;
__attribute__ ((deprecated("Use ASKPAlertRatingRemindMe"))) static const APAlertRatingButtonType APAlertRatingRemindMe = ASKPAlertRatingRemindMe;

#endif
