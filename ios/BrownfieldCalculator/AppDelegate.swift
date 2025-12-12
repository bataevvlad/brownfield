import UIKit
import React

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        guard let bundleURL = bundleURL() else {
            return false
        }

        let rootView = RCTRootView(
            bundleURL: bundleURL,
            moduleName: "main",
            initialProperties: nil,
            launchOptions: launchOptions
        )
        rootView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1)

        let rootViewController = UIViewController()
        rootViewController.view = rootView
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }

    private func bundleURL() -> URL? {
        #if DEBUG
        return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
        #else
        return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
        #endif
    }
}
