//
//  ALDemoRootViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/23/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

@import AppLovinSDK;
#import "ALDemoRootViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <SafariServices/SafariServices.h>

@interface ALDemoRootViewController()<MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) IBOutlet UIBarButtonItem *muteToggle;
@end

@implementation ALDemoRootViewController
static NSString *const kSupportEmail = @"support@applovin.com";
static NSString *const kSupportLink = @"https://support.applovin.com/support/home";

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden: YES];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    logo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    logo.image = [UIImage imageNamed: @"nav_logo"];
    self.navigationItem.titleView = logo;
    
    [self addFooterLabel];
    
    self.muteToggle.image = [self muteIconForCurrentSdkMuteSetting];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];

    // Re-set status bar style after returning from SFSafariViewController
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
#pragma GCC diagnostic pop
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    
    if ( indexPath.section == 1 )
    {
        if ( indexPath.row == 0 )
        {
            [self openSupportSite];
        }
        else if ( indexPath.row == 1 )
        {
            [self attemptSendEmail];
        }
    }
}

#pragma mark - Sound Toggling

- (IBAction)toggleMute:(UIBarButtonItem *)sender
{
    /**
     * Toggling the sdk mute setting will affect whether your video ads begin in a muted state or not.
     */
    ALSdk *sdk = [ALSdk shared];
    sdk.settings.muted = !sdk.settings.muted;
    sender.image = [self muteIconForCurrentSdkMuteSetting];
}

- (UIImage *)muteIconForCurrentSdkMuteSetting
{
    return [ALSdk shared].settings.muted ? [UIImage imageNamed: @"mute"] : [UIImage imageNamed: @"unmute"];
}

#pragma mark - Table View Actions

- (void)openSupportSite
{
    NSOperatingSystemVersion version = [[NSProcessInfo processInfo]operatingSystemVersion];
    if ( version.majorVersion > 8 )
    {
        SFSafariViewController *safariController = [[SFSafariViewController alloc] initWithURL: [NSURL URLWithString: kSupportLink]
                                                                       entersReaderIfAvailable: YES];
        [self presentViewController: safariController animated: YES completion:^{
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
            [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
#pragma GCC diagnostic pop
        }];
    }
    else
    {
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: kSupportLink]];
    }
}

- (void)attemptSendEmail
{
    if ( [MFMailComposeViewController canSendMail] )
    {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate = self;
        [mailController setSubject: @"iOS SDK support"];
        [mailController setToRecipients: @[kSupportEmail]];
        [mailController setMessageBody: [NSString stringWithFormat: @"\n\n---\nSDK Version: %@", [ALSdk version]] isHTML: NO];
        mailController.navigationBar.tintColor = [UIColor whiteColor];
        [self presentViewController: mailController animated: YES completion:^{
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
            [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
#pragma GCC diagnostic pop
        }];
    }
    else
    {
        NSString *message = [NSString stringWithFormat: @"Your device is not configured for sending emails.\n\nPlease send emails to %@", kSupportEmail];
        [[[UIAlertView alloc] initWithTitle: @"Email Unavailable"
                                    message: message
                                   delegate: nil
                          cancelButtonTitle: @"OK"
                          otherButtonTitles: nil] show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch ( result )
    {
        case MFMailComposeResultSent:
            [[[UIAlertView alloc] initWithTitle: @"Email Sent"
                                        message: @"Thank you for your email, we will process it as soon as possible."
                                       delegate: nil
                              cancelButtonTitle: @"OK"
                              otherButtonTitles: nil] show];
        case MFMailComposeResultCancelled:
        case MFMailComposeResultSaved:
        case MFMailComposeResultFailed:
        default:
            break;
    }
    
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void)addFooterLabel
{
    UILabel *footer = [[UILabel alloc] init];
    footer.font = [UIFont systemFontOfSize: 14.0f];
    footer.numberOfLines = 0;
    
    NSString *appVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *sdkVersion = [ALSdk version];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *text = [NSString stringWithFormat: @"App Version: %@\nSDK Version: %@\niOS Version: %@\n\nLanguage: Objective-C", appVersion, sdkVersion, systemVersion];
    
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.alignment =  NSTextAlignmentCenter;
    style.minimumLineHeight = 20.0f;
    footer.attributedText = [[NSAttributedString alloc] initWithString: text attributes: @{NSParagraphStyleAttributeName : style}];
    
    CGRect frame = footer.frame;
    frame.size.height = [footer sizeThatFits: CGSizeMake(CGRectGetWidth(footer.frame), CGFLOAT_MAX)].height + 60.0f;
    footer.frame = frame;
    self.tableView.tableFooterView = footer;
}

@end
