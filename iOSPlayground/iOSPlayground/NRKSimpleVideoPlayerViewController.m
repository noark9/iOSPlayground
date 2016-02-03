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
@property (nonatomic, strong) AVAsset *asset;
@property (nonatomic, strong) AVPlayerItem *playerItem;
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
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:self.addressTextField.text] options:nil];
        self.asset = urlAsset;
        __weak typeof(self) weakSelf = self;
        [self.class createSeamlessLoopAssetWithAsset:urlAsset complete:^(AVComposition *composition) {
            weakSelf.playerItem = [AVPlayerItem playerItemWithAsset:composition];
            weakSelf.player = [AVPlayer playerWithPlayerItem:weakSelf.playerItem];
            weakSelf.playerLayer = [AVPlayerLayer playerLayerWithPlayer:weakSelf.player];
            weakSelf.playerLayer.frame = weakSelf.playerView.bounds;
            weakSelf.playerLayer.videoGravity = AVLayerVideoGravityResize;
            [weakSelf.playerView.layer addSublayer:weakSelf.playerLayer];
            [weakSelf.player play];
        }];
    }
}

+ (void)createSeamlessLoopAssetWithAsset:(AVAsset *)asset complete:(void (^) (AVComposition *composition))complete {
    [asset loadValuesAsynchronouslyForKeys:@[@"duration"] completionHandler:^{
        AVMutableComposition *composition = [AVMutableComposition composition];
        CMTime duration = asset.duration;
        CMTime timeToCut = CMTimeMakeWithSeconds(0.05f, duration.timescale);
        duration = CMTimeSubtract(duration, timeToCut);
        duration = CMTimeSubtract(duration, timeToCut);
        CMTime startTime = kCMTimeZero;
        CMTime currentDuration = kCMTimeZero;
        for (int i = 0; i < 20; i++) {
            [composition insertTimeRange:CMTimeRangeMake(startTime, duration) ofAsset:asset atTime:currentDuration error:NULL];
            currentDuration = composition.duration;
            startTime = timeToCut;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(composition.copy);
        });
    }];
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
