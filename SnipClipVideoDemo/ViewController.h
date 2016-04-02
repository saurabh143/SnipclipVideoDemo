//
//  ViewController.h
//  SnipClipVideoDemo
//
//  Created by Saurabh Yadav on 03/04/16.
//  Copyright © 2016 Saurabh Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet YTPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UITextField *videoIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextField;

@end

