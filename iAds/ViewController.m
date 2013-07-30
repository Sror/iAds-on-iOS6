#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) ADBannerView *adBannerView;

@end


@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.adBannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    self.adBannerView.delegate = self;
    [self.adBannerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    self.adBannerView.hidden = YES;
    [self.view addSubview:_adBannerView];
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    CGRect bannerFrame = CGRectZero;
    CGSize iPad = CGSizeMake(0.0, 66.0);
    CGSize iPhonePortrait = CGSizeMake(0.0, 50.0);
    CGSize iPhoneLandscape = CGSizeMake(0.0, 32.0);
    CGSize deviceSize = self.view.bounds.size;
    
    if ([self currentDevice]) { // iPad
        if ([self currentOrientation]) { // portrait
            bannerFrame = CGRectMake(0.0,
                                     deviceSize.height - iPad.height,
                                     deviceSize.width,
                                     iPad.height);
        } else {
            bannerFrame = CGRectMake(0.0,
                                     deviceSize.height - iPad.height,
                                     deviceSize.width,
                                     iPad.height);
        }
    } else { // iPhone
        if ([self currentOrientation]) {
            bannerFrame = CGRectMake(0.0,
                                    deviceSize.height - iPhonePortrait.height,
                                    deviceSize.width,
                                    iPhonePortrait.height);
        } else {
            bannerFrame = CGRectMake(0.0,
                                    deviceSize.height - iPhoneLandscape.height,
                                    deviceSize.width,
                                    iPhoneLandscape.height);
        }
    }
    
    [self.adBannerView setFrame:bannerFrame];
    self.adBannerView.hidden = NO;
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
     self.adBannerView.hidden = YES;
}

-(BOOL)currentOrientation {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return 0; // landscape
    }
    return 1; // portrait
}

-(BOOL)currentDevice {
    if ([[UIDevice currentDevice] userInterfaceIdiom]) {
        return 1; // iPad device
    }
    return 0; // iPhone device
}


@end
