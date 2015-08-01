//
//  NRKSimpleVideoPlayerViewController.m
//  iOSPlayground
//
//  Created by noark on 7/31/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import "NRKSimpleVideoPlayerViewController.h"

@import AVFoundation;

@interface NRKSimpleVideoPlayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@end

@implementation NRKSimpleVideoPlayerViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [self resetButtonPushed:nil];
}

- (IBAction)playButtonPushed:(id)sender
{
    if (!self.player) {
        self.player = [AVPlayer playerWithURL:[NSURL URLWithString:self.addressTextField.text]];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = self.playerView.bounds;
        self.playerLayer.videoGravity = AVLayerVideoGravityResize;
        [self.playerView.layer addSublayer:self.playerLayer];
    }
    if (self.player.rate > 0.0f) {
        return;
    }
    [self.player play];
}

- (IBAction)resetButtonPushed:(id)sender
{
    [self.player pause];
    [self.playerLayer removeFromSuperlayer];
    self.playerLayer = nil;
    self.player = nil;
}

- (IBAction)loadYoukuVideoButtonPushed:(id)sender
{
    
}

@end
