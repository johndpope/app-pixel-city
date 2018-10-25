
import UIKit
import Fabric
import Crashlytics
import CocoaLumberjack
import LumberjackConsole

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Fabric.with([Crashlytics.self])
        
        DM.populateData()
        buildWindow()
        configureAppearanceService()
       
        APIManager.shared.fetchLandingContent()
     
        return true
    }

    
    // Create main window with uitabar controller via MyTabBar
    // encapsulate view controllers inside uinvagigation controllers
    func buildWindow() {
        window = UIWindow.window()
        DM.weakWindow = window
        
        let mainTBC = UITabBarController()
        MyTabBar.shared.weakMainTBC = mainTBC
        mainTBC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainTBC.viewControllers = MyTabBar.buildNavigationControllers()
        mainTBC.delegate = MyTabBar.shared
        mainTBC.tabBar.isTranslucent = true
        window?.rootViewController = mainTBC
        window?.makeKeyAndVisible()
    }
    
   
    // Used to configure all uiview colors / fonts etc
    func configureAppearanceService() {
        print("Enabling AppearanceService proxy")
        AppearanceService.shared.setGlobalAppearance()
    }

}

