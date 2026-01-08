import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let calculatorVC = CalculatorViewController()
        let navigationController = UINavigationController(rootViewController: calculatorVC)
        navigationController.navigationBar.prefersLargeTitles = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
