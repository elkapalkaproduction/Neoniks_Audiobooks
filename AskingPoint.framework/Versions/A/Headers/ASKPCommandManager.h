//
//  ASKPCommandManager.h
//  AskingPoint
//
//  Copyright (c) 2012 KnowFu Inc. All rights reserved.
//
#import <AskingPoint/ASKPContext.h>
#import <AskingPoint/ASKPCommand.h>

@class ASKPCommandManager;

@protocol ASKPCommandManagerDelegate
@required
-(void)commandManager:(ASKPCommandManager*)commandManager reportAlertResponseForCommand:(ASKPCommand*)command button:(ASKPAlertButton*)pressed;
@end

typedef void (^ASKPCommandManagerRequestComplete)(NSString *tag, ASKPCommand *command);


@interface ASKPCommandManager : NSObject

@property(nonatomic,assign) id<ASKPCommandManagerDelegate> commandDelegate;

-(void)requestCommandsWithTag:(NSString*)tag completionHandler:(ASKPCommandManagerRequestComplete)completionHandler;
-(void)reportAlertResponseForCommand:(ASKPCommand*)command button:(ASKPAlertButton*)button;

@end

#ifndef __ASKINGPOINT_NO_COMPAT

@compatibility_alias APCommandManager ASKPCommandManager;
typedef __attribute__((deprecated)) ASKPCommandManagerRequestComplete APCommandManagerRequestComplete;

#endif