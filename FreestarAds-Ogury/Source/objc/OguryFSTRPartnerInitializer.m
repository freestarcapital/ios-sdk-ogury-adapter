//
//  OguryFSTRPartnerInitializer.m
//  FreestarAds-Ogury
//
//  Created by Carlos Alcala on 7/04/22.
//

#import "OguryFSTRPartnerInitializer.h"
#import <OgurySdk/Ogury.h>
#import <OguryAds/OguryAds.h>
#import <OguryChoiceManager/OguryChoiceManager.h>

@implementation OguryFSTRPartnerInitializer

+ (instancetype)shared {
    static OguryFSTRPartnerInitializer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[OguryFSTRPartnerInitializer alloc] init];
    });
    return instance;
}

- (void)runInitialization {
    // run partner initialization here
    FSTRLog(@"OGURY: Partner initialization.");
    OguryConfigurationBuilder *configurationBuilder = [[OguryConfigurationBuilder alloc] initWithAssetKey:@"OGY-773308830772"];
    [Ogury startWithConfiguration:[configurationBuilder build]];
}

@end
