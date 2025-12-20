import UIKit
@_implementationOnly import React

public class ReactBrownfieldRootViewManager {
    public static let shared = ReactBrownfieldRootViewManager()

    private var bridge: RCTBridge?

    private init() {
        initializeBridge()
    }

    private func initializeBridge() {
        let bundleURL: URL?
        #if DEBUG
        bundleURL = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
        #else
        bundleURL = Bundle(for: Self.self).url(forResource: "main", withExtension: "jsbundle")
        #endif

        bridge = RCTBridge(bundleURL: bundleURL, moduleProvider: nil, launchOptions: nil)
    }

    /// Loads a React Native view with the given module name.
    ///
    /// React components are registered as modules by using the AppRegistry API.
    /// - Parameter moduleName: Name used while registering the React Component with the `AppRegistry` API.
    /// - Parameter initialProps: Props that are going to be passed to the React Component.
    /// - Parameter launchOptions: The options app was launched with.
    @objc public func loadView(
        moduleName: String,
        initialProps: [AnyHashable: Any]?,
        launchOptions: [AnyHashable: Any]?
    ) -> UIView {
        guard let bridge = bridge else {
            let errorView = UIView()
            errorView.backgroundColor = .red
            return errorView
        }

        let rootView = RCTRootView(
            bridge: bridge,
            moduleName: moduleName,
            initialProperties: initialProps as? [String: Any]
        )
        rootView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1)
        return rootView
    }
}
