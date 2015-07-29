//
//  NRKFakeLocationLoader.m
//  iOSPlayground
//
//  Created by noark on 7/30/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import "NRKFakeLocationLoader.h"

@implementation NRKFakeLocationLoader

+ (void)locationOnComplete:(void (^)())complete
{
    if (!complete) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        complete();
    });
}

@end
