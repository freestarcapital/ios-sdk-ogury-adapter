//
//  OguryBannerMediator.m
//  FreestarAds-Ogury
//
//  Created by Carlos Alcala on 7/04/22.
//

#import "OguryBannerMediator.h"
#import <FreestarAds/FreestarAds.h>
#import <UIKit/UIKit.h>
#import <OguryAds/OguryAds.h>
#import <OguryChoiceManager/OguryChoiceManager.h>

@interface OguryBannerMediator()<OguryBannerAdDelegate, FSTRMediatorEnabling>

@property (nonatomic, strong) OguryBannerAd *ad;
@property OguryAdsBannerSize *requestedSize;
@property CGFloat requestedWidth;
@property(nonatomic, assign) FreestarBannerAdSize freestarAdSize;

@end

@implementation OguryBannerMediator

- (BOOL)isEnabledForMediatorFormat:(FSTRMediatorFormatType)type {
    switch (type) {
        case FSTRMediatorFormatTypeBanner:
        case FSTRMediatorFormatTypeInline:
            return YES;
        default:
            return NO;
    }
}

- (BOOL)canShowBannerAd {
    return YES;
}

- (BOOL)canShowInlineInviewAd {
    return YES;
}

- (BOOL)isAdaptiveEnabled {
    return [Freestar adaptiveBannerEnabled];
}

-(void)loadBannerAd {
    [self loadInlineInviewAd];
}

- (void)loadInlineInviewAd {
    FSTRLog(@"OGURY: loadBannerAd");
    FSTRLog(@"OGURY: adunitId %@", [self.mPartner adunitId]);

    if ([self.mPartner adunitId] == nil) {
        [self partnerAdLoadFailed:@"adunitId is nil"];
        return;
    }

    self.ad = [[OguryBannerAd alloc] initWithAdUnitId:[self.mPartner adunitId]];
    self.ad.delegate = self;
    [self.ad loadWithSize:self.requestedSize];
}

#pragma mark - showing

- (void)showAd {
    if (self.ad) {
        FSTRLog(@"OGURY: showAd - placeAdContent");

        self.ad.frame = [self frameFromSize:self.requestedSize];
        [self.container placeAdContent:self.ad];
    }
}

- (CGRect)frameFromSize:(OguryAdsBannerSize*)size {
    return CGRectMake(0, 0, (CGFloat)size.getSize.width, (CGFloat)size.getSize.height);
}

#pragma mark - OguryBannerAdDelegate

- (void)didLoadOguryBannerAd:(OguryBannerAd *)banner {
    FSTRLog(@"OGURY: didLoadOguryBannerAd");

    self.ad = banner;
    [self partnerAdLoaded];
}

- (void)didClickOguryBannerAd:(OguryBannerAd *)banner {
    FSTRLog(@"OGURY: didClickOguryBannerAd");
    [self partnerAdClicked];
}

- (void)didCloseOguryBannerAd:(OguryBannerAd *)banner {
    FSTRLog(@"OGURY: didCloseOguryBannerAd");
    [self partnerAdDone];
}

- (void)didDisplayOguryBannerAd:(OguryBannerAd *)banner {
    FSTRLog(@"OGURY: didDisplayOguryBannerAd");

    [self partnerAdShown];
}

- (void)didFailOguryBannerAdWithError:(OguryError *)error forAd:(OguryBannerAd *)banner {
    FSTRLog(@"OGURY: didFailOguryBannerAdWithError %@", [error localizedDescription]);

   [self partnerAdLoadFailed:[NSString stringWithFormat:@"%ld", (long)error.code]];
}

- (void)didTriggerImpressionOguryBannerAd:(OguryBannerAd *)banner {
    FSTRLog(@"OGURY: didTriggerImpressionOguryBannerAd");
}

- (UIViewController *)presentingViewControllerForOguryAdsBannerAd:(OguryBannerAd*)banner {
    FSTRLog(@"OGURY: presentingViewControllerForOguryAdsBannerAd");
    return self.presenter;
}

#pragma mark - Helper Mediator Functions
- (BOOL)supportsBanner:(FreestarBannerAdSize)adSize {
    self.freestarAdSize = adSize;
    switch(adSize){
        case FreestarBanner320x50:
            self.requestedSize = [OguryAdsBannerSize small_banner_320x50];
            return YES;
        case FreestarBanner300x250:
            self.requestedSize = [OguryAdsBannerSize mpu_300x250];
            return YES;
        case FreestarBanner728x90:
        default:
            return NO;
    }
}

@end
