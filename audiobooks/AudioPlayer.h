//
//  AudioPlayer.h
//  audiobooks
//
//  Created by Andrei Vidrasco on 3/22/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface AudioPlayer : NSObject<UIAlertViewDelegate>
+ (id)sharedManager;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (assign, nonatomic) int currentTrack;
@property (assign, nonatomic) BOOL languageRussian;
-(void)playBook:(int)currentTrack;
-(void)stop;
@end
