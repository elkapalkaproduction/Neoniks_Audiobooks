//
//  AudioPlayer.m
//  audiobooks
//
//  Created by Andrei Vidrasco on 3/22/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "AudioPlayer.h"

@implementation AudioPlayer
+ (id)sharedManager {
    static AudioPlayer *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void)playBook:(int)currentTrack{
    if (_currentTrack == currentTrack) {
        if ([_audioPlayer isPlaying]) {
            [_audioPlayer pause];
        } else {
            [_audioPlayer play];
        }
    } else {
        [self stop];
     _currentTrack = currentTrack;
    NSString *title =[Utils getTitle:currentTrack];
    NSString *titleLocalized = AVLocalizedSystem(title);
    NSURL *url = [[NSBundle mainBundle] URLForResource:titleLocalized withExtension:@"mp3"];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    NSString *key =[NSString stringWithFormat:@"%d%@",_currentTrack,[[NSUserDefaults standardUserDefaults] objectForKey:kLanguage]];
    [_audioPlayer prepareToPlay];

        if ([[[NSUserDefaults standardUserDefaults] objectForKey:key] doubleValue] > 0) {
            [[[UIAlertView alloc] initWithTitle:@"" message:[Utils getStringFromPlist:@"Continue playing"] delegate:self cancelButtonTitle:[Utils getStringFromPlist:@"From beginning"] otherButtonTitles:[Utils getStringFromPlist:@"Continue"], nil] show];
            
        } else {
            [_audioPlayer play];
        }
   

    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *key =[NSString stringWithFormat:@"%d%@",_currentTrack,[[NSUserDefaults standardUserDefaults] objectForKey:kLanguage]];
        NSTimeInterval timeInteval =[[[NSUserDefaults standardUserDefaults] objectForKey:key] doubleValue];
        [_audioPlayer setCurrentTime:timeInteval];

    }
     [_audioPlayer play];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"alertClicked" object:nil userInfo:nil];
}
-(void)stop{
    NSString *key =[NSString stringWithFormat:@"%d%@",_currentTrack,[[NSUserDefaults standardUserDefaults] objectForKey:kLanguage]];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:_audioPlayer.currentTime] forKey:key];
    _currentTrack = 0;
    [_audioPlayer stop];
    _audioPlayer = nil;
}
@end
