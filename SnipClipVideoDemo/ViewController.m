//
//  ViewController.m
//  SnipClipVideoDemo
//
//  Created by Saurabh Yadav on 03/04/16.
//  Copyright © 2016 Saurabh Yadav. All rights reserved.
//

#import "ViewController.h"
#import "M13ProgressView.h"
#import "M13ProgressViewPie.h"

@interface ViewController ()<YTPlayerViewDelegate>{
    UIButton *playVideoButton;
    BOOL isVideoPlaying;
    M13ProgressViewPie *pie;
    NSTimer *timerOnPie;
    float progress;
    int startTimeForVideo;
    int endTimeForVideo;
    float callbackTimerForPie;
    float progressPerTimerCall;
}

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    isVideoPlaying = NO;
    startTimeForVideo = 10;
    endTimeForVideo = 50;
    NSDictionary *playerVars = @{
                                 @"playsinline" : @1,
                                 @"start" : [NSNumber numberWithInt:startTimeForVideo],
                                 @"end" : [NSNumber numberWithInt:endTimeForVideo],
                                 @"controls": @0,
                                 @"rel":@0
                                 };
    
    [self.playerView loadWithVideoId:@"xoZl_5UT4n4" playerVars:playerVars];
    self.playerView.delegate = self;
    [self configureThePieView];
    [self loadPieChartTimeConfiguration];
    progress = 0;
}

- (void)loadPieChartTimeConfiguration{
    callbackTimerForPie = (endTimeForVideo - startTimeForVideo) /100.0;
    progressPerTimerCall = 0.1/(callbackTimerForPie*(endTimeForVideo - startTimeForVideo)) ;
}

- (void) increasePieTime:(id)sender{
    progress = progress + progressPerTimerCall;
    [pie setProgress:.5 animated:YES];
}

- (void)configureThePieView{
    pie = [[M13ProgressViewPie alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height - 200, 100, 100)];
    //Set any properties you want to change.
    pie.primaryColor = [UIColor yellowColor];
    pie.secondaryColor = [UIColor colorWithRed:244/255.0 green:208/255.0 blue:63/255.0 alpha:1.0];
    pie.layer.cornerRadius = 15;
    [self.view addSubview:pie];
}

- (IBAction)playPressed:(id)sender{
    if (isVideoPlaying) {
        [timerOnPie invalidate];
        [self.playerView pauseVideo];
    }
    else{
        [self.playerView playVideo];
    }
}

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state) {
        case kYTPlayerStatePlaying:
            NSLog(@"Started playback");
            timerOnPie = [NSTimer scheduledTimerWithTimeInterval: callbackTimerForPie
                                                          target: self
                                                        selector:@selector(increasePieTime:)
                                                        userInfo: nil repeats:YES];
            isVideoPlaying = YES;
            break;
        case kYTPlayerStatePaused:
            NSLog(@"Paused playback");
            [timerOnPie invalidate];
            isVideoPlaying = NO;
            break;
        case kYTPlayerStateEnded:
            NSLog(@"ended i think");
            [self resetTheVideoOnceMore];
            [self.playerView stopVideo];
            isVideoPlaying = NO;
        case kYTPlayerStateUnknown:
            NSLog(@"take it for granted");
            [timerOnPie invalidate];
            [pie setProgress:0 animated:NO];
            progress = 0;
        default:
            break;
    }
}

- (void)resetTheVideoOnceMore{
    NSDictionary *playerVars = @{
                                 @"playsinline" : @1,
                                 @"start" : [NSNumber numberWithInt:startTimeForVideo],
                                 @"end" : [NSNumber numberWithInt:endTimeForVideo],
                                 @"controls": @0,
                                 @"rel":@0
                                 };
    [self.playerView loadWithVideoId:@"xoZl_5UT4n4" playerVars:playerVars];
}

- (IBAction)loadVideoPressed:(id)sender {
    if (self.videoIdTextField.text ==0 || self.startTimeTextField.text == 0 || self.endTimeTextField.text == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please fill all the required Fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}


@end
