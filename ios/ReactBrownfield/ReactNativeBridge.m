#import <React/RCTBridgeModule.h>
#import <UIKit/UIKit.h>

@interface ReactNativeBridge : NSObject <RCTBridgeModule>
@end

@implementation ReactNativeBridge

RCT_EXPORT_MODULE();

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

RCT_EXPORT_METHOD(dismiss) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        UIViewController *presentedVC = rootVC;

        // Find the topmost presented view controller
        while (presentedVC.presentedViewController != nil) {
            presentedVC = presentedVC.presentedViewController;
        }

        // Dismiss if there's a presented view controller
        if (presentedVC != rootVC) {
            [presentedVC dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

@end
