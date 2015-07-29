//
//  NRKFakeVideoUploader.m
//  iOSPlayground
//
//  Created by noark on 7/30/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import "NRKFakeVideoUploader.h"

@implementation NRKFakeVideoUploader

- (void)upload
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(nrk_fakeVideoDidFinishedUpload)]) {
            [self.delegate nrk_fakeVideoDidFinishedUpload];
        }
    });
}

@end
