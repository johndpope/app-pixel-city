import Foundation
import CocoaLumberjack
import Material
class MyNavigationController: UINavigationController {
    
}

public enum tabBarTag: Int {
    case landing = 0
    case blank = 1
    case map = 2

}


class MyTabBar: NSObject {

    static let shared = MyTabBar()
    weak var weakMainTBC: UITabBarController?

 
    // Here we are wrapping viewcontrollers with a uinavigation controller.
    //
    class func buildNavigationControllers() -> [UIViewController] {

        // Landing Page / Navigation Controller
        let landingVC = LandingVC()
        let landingNC = buildNavigationController(vc:landingVC)
        DM.weakLandingNC = landingNC
        landingNC.tabBarItem = tabBarItem(title: "Splash", imageName: "PhotoIcon", selectedImageName: "PhotoIcon", tagIndex: tabBarTag.landing.rawValue)
        
   
        // 2nd Tab
        let blankVC = UIViewController()
        blankVC.title = "Blank"
        let blankNC = buildNavigationController(vc:blankVC)
        blankNC.tabBarItem = tabBarItem(title: "Apple", imageName: "AppleIcon", selectedImageName: "AppleIcon", tagIndex: tabBarTag.blank.rawValue)

        
        // Mapper
        let mapVC = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: "MapViewControllerId")
        mapVC.title = "Map"
        let mapNC = buildNavigationController(vc:mapVC)
        mapNC.tabBarItem = tabBarItem(title: "Map", imageName: "GlobeIcon", selectedImageName: "GlobeIcon", tagIndex: tabBarTag.map.rawValue)


        return  [landingNC,blankNC,mapNC]
    }

    class func tabBarItem(title: String, imageName: String, selectedImageName: String, tagIndex: Int) -> UITabBarItem {
        let item = UITabBarItem(title: title,
                                image: UIImage(named: imageName),
                                selectedImage: UIImage(named: selectedImageName))
        item.titlePositionAdjustment = UIOffset(horizontal:0, vertical:-5)
        item.tag = tagIndex
        return item
    }

    class func buildNavigationController(vc: UIViewController) -> MyNavigationController {

        let nc = MyNavigationController()
        nc.navigationBar.isTranslucent = false
        nc.viewControllers = [vc]
        
        return nc
    }
  
    
    // why does this exist? the titles / navigation item titles differ - this fixes things
    class func resyncTabBarTitles() {
        if let vcs = MyTabBar.shared.weakMainTBC?.viewControllers {
            for (index, vc) in vcs.enumerated() {
                if index == tabBarTag.landing.rawValue {
                    vc.tabBarItem.title = "landing"
                }
                if index == tabBarTag.blank.rawValue {
                    vc.tabBarItem.title = "blank"
                }
                if index == tabBarTag.map.rawValue {
                    vc.tabBarItem.title = "map"
                }
                
                
            }
        }
    }

    
  
}




