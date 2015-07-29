//
//  NRKFakeVideoEncoder.h
//  iOSPlayground
//
//  Created by noark on 7/30/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NRKFakeVideoEncoderProtocal <NSObject>

- (void)nrk_fakeVideoDidFinishedEncode;
- (void)nrk_fakeVideoDidFailedEncode;

@end

@interface NRKFakeVideoEncoder : NSObject

@property (weak, nonatomic) id<NRKFakeVideoEncoderProtocal> delegate;
- (void)encode;

@end
