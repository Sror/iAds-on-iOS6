//
//  ViewController.m
//  test1
//
//  Created by Shams on 17/06/2013.
//  Copyright (c) 2013 GlobalReach. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property ADBannerView *adBannerView;
@property BOOL currentOrientation;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(currentOrientation:)
                                                 name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    
    _adBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    [_adBannerView setDelegate:self];
    [_adBannerView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin)];
    _adBannerView.hidden = YES;
    [self.view addSubview:_adBannerView];
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    CGRect bannerFrame = CGRectZero;
    CGSize iPadBasic = CGSizeMake(0.0, 66.0);
    CGSize iPhoneBasic = CGSizeMake(0.0, 32.0);
    CGSize deviceSize = self.view.bounds.size;
    
    if([self currentDevice]) { // iPad
        if (_currentOrientation == 0) {
            bannerFrame = CGRectMake(0.0, deviceSize.width - iPadBasic.height, deviceSize.height , deviceSize.width);
        } else {
            bannerFrame = CGRectMake(0.0, deviceSize.height - iPadBasic.height, deviceSize.width, iPadBasic.height);
        }
    } else { // iPhone
        if (_currentOrientation) { // iphone portrait
            bannerFrame = CGRectMake(0.0, self.view.frame.size.height - 50, 0.0, 0.0);
            } else {
            bannerFrame = CGRectMake(0.0, self.view.frame.size.height - iPhoneBasic.height, self.view.bounds.size.width, 0.0);
            }
    }
    [_adBannerView setFrame:bannerFrame];
    _adBannerView.hidden = NO;
   
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
     _adBannerView.hidden = YES;
}

-(void)currentOrientation:(NSNotification *)notification {
    if ([[notification object] orientation] != 3 && [[notification object] orientation] != 4 && [[notification object] orientation] != 5 && [[notification object] orientation] != 6) {
        _currentOrientation = 1; // Portrait mode
    } else if ([[notification object] orientation] != 5 && [[notification object] orientation] != 6) {
        _currentOrientation = 0; // landscape mode
    }
}

-(BOOL)currentDevice {
    if ([[UIDevice currentDevice] userInterfaceIdiom]) {
        return 1; // iPad device
    } else {
        return 0; // iPhone device
    }
}


@end
