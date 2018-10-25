
import UIKit
import Fabric
import Crashlytics
import CocoaLumberjack
import LumberjackConsole

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Fabric.with([Crashlytics.self])
        
        DM.populateData()
        buildWindow()
        configureAppearanceService()
       
        return true
    }

    func buildWindow() {
        window = UIWindow.window()
        DM.weakWindow = window
        
        let mainTBC = UITabBarController()
        MyTabBar.shared.weakMainTBC = mainTBC
        mainTBC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainTBC.viewControllers = MyTabBar.buildNavigationControllers()
        mainTBC.delegate = MyTabBar.shared
        window?.rootViewController = mainTBC
        window?.makeKeyAndVisible()
    }
    
   
    func configureAppearanceService() {
        print("Enabling AppearanceService proxy")
        AppearanceService.shared.setGlobalAppearance()
    }

}

