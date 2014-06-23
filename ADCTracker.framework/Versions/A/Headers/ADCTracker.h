/*
 * ADCTracker.h
 * adc-ios-advertiser-sdk
 *
 * Created by AdColony on 11/21/13.
 */

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Constants

/**
 * Enum for custom events
 */
typedef enum {
    ADCT_CUSTOM_EVENT_1 = 1,
    ADCT_CUSTOM_EVENT_2,
    ADCT_CUSTOM_EVENT_3,
    ADCT_CUSTOM_EVENT_4,
    ADCT_CUSTOM_EVENT_5
} ADCT_CUSTOM_EVENT;

/**
 * Enum for social network registration events
 */
typedef enum {
    ADCT_DEFAULT_REGISTRATION = 1,
    ADCT_FACEBOOK_REGISTRATION,
    ADCT_TWITTER_REGISTRATION,
    ADCT_GOOGLE_REGISTRATION,
    ADCT_LINKEDIN_REGISTRATION,
    ADCT_OPENID_REGISTRATION,
    ADCT_CUSTOM_REGISTRATION
} ADCT_NETWORK_REGISTRATION_METHOD;

/**
 * Enum for social network sharing events
 */
typedef enum {
    ADCT_FACEBOOK_SHARING = 1,
    ADCT_TWITTER_SHARING,
    ADCT_GOOGLE_SHARING,
    ADCT_LINKEDIN_SHARING,
    ADCT_PINTEREST_SHARING,
    ADCT_YOUTUBE_SHARING,
    ADCT_INSTAGRAM_SHARING,
    ADCT_TUMBLR_SHARING,
    ADCT_FLICKR_SHARING,
    ADCT_VIMEO_SHARING,
    ADCT_FOURSQUARE_SHARING,
    ADCT_VINE_SHARING,
    ADCT_CUSTOM_SHARING
} ADCT_SOCIAL_SHARING_NETWORK;


#pragma mark -
#pragma mark ADCTracker interface

/**
 * The ADCTracker class provides a method to start the AdColony tracker.
 */
@interface ADCTracker : NSObject


// ***************** STARTING THE ADCOLONY TRACKING SDK ***************** //

/**
 * Starts the AdColony tracking sdk for your app - required for usage of the rest of the API.
 * @param appID Your AdColony app ID.
 * @param userID A arbitrary custom identifier for the current app user. Passing in a nil value is allowed, 
 * and you can set the custom ID at any time during the execution of your app.
 * @see setCustomID
 * @param logging A boolean for turning logging on or off.
 * @param options An NSDictionary for optional configuration parameters.
 */
+ ( void ) startWithAppID:( NSString * )appID userID:( NSString * )userID logging:( BOOL )logging options:( NSDictionary * )options;


// ******************* REPORTING MONETIZATION EVENTS  ****************** //

/**
 * Reports a user has made a purchase.
 * @param productID An NSString identifying the purchased product.
 * @param quantity An int indicating the number of items.
 * @param price A double indicating the total price of the items purchased.
 * @param currencyCode An NSString indicating the real-world currency code of transaction. Passing a nil value is allowed.
 * @param receiptNumber An NSString indicating the receipt number. Passing a nil value is allowed.
 * @param store An NSString to describe the store the purchase was made through. Passing a nil value is allowed.
 * @param description An NSString to describe the purchased product. Passing a nil value is allowed.
 */
+ ( void ) transactionWithProductID:( NSString * )productID quantity:( int )quantity price:( double )price currencyCode:( NSString * )currencyCode
                      receipt:( NSString * )receipt store:( NSString * )store description:( NSString * )description;
/**
 * Reports a user has spent some credits.
 * @param quantity An int indicating the number of credits the user has spent.
 * @param name An NSString indicating the type of credits the user has spent.
 * @param value A double indiciating the real-world value of the credits spent. Passing a nil value is allowed.
 * @param code An NSString indicating the real-world currency code of the credits. Passing a nil value is allowed.
 */
+ ( void ) creditsSpent:( int )quantity name:( NSString * )name value:( NSNumber * )value currencyCode:( NSString * )currencyCode;

/**
 * Reports a user added payment information.
 */
+ ( void ) paymentInfoAdded;


// ******************** REPORTING MILESTONE EVENTS  ******************* //

/**
 * Reports a user unlocked an achievement.
 * @param description An NSString describing the achievement. Passing a nil value is allowed.
 */
+ ( void ) achievementUnlockedWithDescription:( NSString * )description;

/**
 * Reports a user has achieved a certain level in a game.
 * @param level An int indicating the level achieved by the user.
 */
+ ( void ) levelAchieved:( int )level;

/**
 * Reports a user has rated an application.
 */
+ ( void ) applicationRated;

/**
 * Reports a user has activated an app or account.
 */
+ ( void ) activatedAppOrAccount;

/**
 * Reports a user has completed a tutorial.
 */
+ ( void ) tutorialCompleted;

// ***************** REPORTING SOCIAL NETWORK EVENTS  ***************** //

/**
 * Reports a social sharing event by the user.
 * @param network An ADCT_SOCIAL_SHARING_NETWORK indicating the associated social network.
 * @param description An NSString describing the event. Only pass this in if you are registering a custom network 
 * sharing experience - will be ignored otherwise.
 */
+ ( void ) socialSharingEventWithNetwork:( ADCT_SOCIAL_SHARING_NETWORK )network description:( NSString * )description;

/**
 * Reports a registration event.
 * @param method An ADCT_NETWORK_REGISTRATION_METHOD indicating the registration method used: Facebook, Twitter, Google, etc.
 * @param description An NSString describing the event. Only pass this in if you are registering a custom registration 
 * event - will be ignored otherwise.
 */
+ ( void ) registrationCompletedWithMethod:( ADCT_NETWORK_REGISTRATION_METHOD )method description:( NSString * )description;

// ********************* REPORTING CUSTOM EVENTS  ********************* //

/**
 * Reports a custom event has occurred. Advertisers are required to keep track of what
 * each ADCT_CUSTOM_EVENT corresponds to.
 * @param event An ADCT_CUSTOM_EVENT denoting the event type.
 * @param description An NSString describing the event.
 */
+ ( void ) customEvent:( ADCT_CUSTOM_EVENT )event description:( NSString * )description;

// ****************** USING A CUSTOM USER IDENTIFIER ***************** //

/**
 * Assigns your own custom identifier to the current app user.
 * @param customID An arbitrary, application-specific identifier string for the current user. Must be less than 128 characters
 * @see getCustomID:
 */
+ ( void ) setCustomID:( NSString * )customID;

/**
 * Returns the device's current custom identifier.
 * @return The custom identifier string most recently set using `+ setCustomID:`.
 * @see setCustomID:
 */
+ ( NSString * ) getCustomID;

@end
