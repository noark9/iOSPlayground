//
//  NRKFakeVideoUploader.h
//  iOSPlayground
//
//  Created by noark on 7/30/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NRKFakeVideoUploaderProtocal <NSObject>

- (void)nrk_fakeVideoDidFinishedUpload;
- (void)nrk_fakeVideoDidFailedUpload;

@end

@interface NRKFakeVideoUploader : NSObject

@property (weak, nonatomic) id<NRKFakeVideoUploaderProtocal> delegate;
- (void)upload;

@end
