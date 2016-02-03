//
//  DisplayLinkViewController.m
//  iOSPlayground
//
//  Created by noark on 9/9/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import "DisplayLinkViewController.h"

@interface DisplayLinkViewController ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation DisplayLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateDisplay:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.displayLink.paused = YES;
    self.displayLink.frameInterval = 60;
}

- (void)dealloc
{
    [self.displayLink invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateDisplay:(CADisplayLink *)displayLink {
    self.label.text = [NSString stringWithFormat:@"duration: %.5f, timestmp: %.5f", displayLink.duration, displayLink.timestamp];
}

- (IBAction)buttonPushed:(id)sender {
    self.displayLink.paused = !self.displayLink.paused;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
