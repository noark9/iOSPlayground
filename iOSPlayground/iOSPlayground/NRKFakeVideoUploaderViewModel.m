//
//  NRKFakeVideoUploaderViewModel.m
//  iOSPlayground
//
//  Created by noark on 7/30/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import "ReactiveCocoa.h"

#import "NRKFakeVideoUploaderViewModel.h"
#import "NRKFakeGeocoder.h"
#import "NRKFakeLocationLoader.h"
#import "NRKFakeVideoEncoder.h"
#import "NRKFakeVideoUploader.h"

@interface NRKFakeVideoUploaderViewModel ()

@property (nonatomic) BOOL locationFinished;
@property (nonatomic) BOOL geocodeFinished;
@property (nonatomic) BOOL encodeFinished;

@property (strong, nonatomic) NRKFakeVideoEncoder *encoder;
@property (strong, nonatomic) NRKFakeVideoUploader *uploader;

@property (strong, nonatomic) RACCommand *uploadCommand;

@end

@implementation NRKFakeVideoUploaderViewModel

+ (instancetype)viewModel
{
    id viewModel = [[self alloc] init];
    return viewModel;
}

- (instancetype)init
{
    if (self = [super init]) {
        // init code
        [self configViewModel];
    }
    
    return self;
}

- (void)configViewModel
{
    RACSignal *locationFinishedSignal = RACObserve(self, locationFinished);
    RACSignal *geocodeFinishedSignal = RACObserve(self, geocodeFinished);
    RACSignal *encodeFinishedSignal = RACObserve(self, encodeFinished);
    RACSignal *readyToUploadSignal = [RACSignal combineLatest:@[locationFinishedSignal, geocodeFinishedSignal, encodeFinishedSignal] reduce:^id(NSNumber *locationFinishValue, NSNumber *geocodeFinisheValue, NSNumber *encodeFinishValue) {
        return @([locationFinishValue boolValue] && [geocodeFinisheValue boolValue] && [encodeFinishValue boolValue]);
    }];
    [NRKFakeLocationLoader locationOnComplete:^{
        self.locationFinished = YES;
        [NRKFakeGeocoder geocodeOnComplete:^{
            self.geocodeFinished = YES;
        }];
    }];
    RACSignal *encodeFinishSignal = [self rac_signalForSelector:@selector(nrk_fakeVideoDidFinishedEncode) fromProtocol:@protocol(NRKFakeVideoEncoderProtocal)];
    [encodeFinishedSignal subscribeNext:^(id x) {
        self.encodeFinished = YES;
    }];
    RACSignal *uploadFinishSignal = [self rac_signalForSelector:@selector(nrk_fakeVideoDidFinishedUpload) fromProtocol:@protocol(NRKFakeVideoUploaderProtocal)];
}

@end
