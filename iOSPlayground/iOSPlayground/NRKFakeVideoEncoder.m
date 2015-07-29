//
//  NRKFakeVideoEncoder.m
//  iOSPlayground
//
//  Created by noark on 7/30/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import "NRKFakeVideoEncoder.h"

@implementation NRKFakeVideoEncoder

- (void)encode
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(nrk_fakeVideoDidFinishedEncode)]) {
            [self.delegate nrk_fakeVideoDidFinishedEncode];
        }
    });
}

@end
