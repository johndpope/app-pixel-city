import Foundation
import CocoaLumberjack
import Material
class MyNavigationController: UINavigationController {
    
}

public enum tabBarTag: Int {
    case featured = 0
    case network = 1

}


class MyTabBar: NSObject {

    static let shared = MyTabBar()
    weak var weakMainTBC: UITabBarController?

 
    // Here we are wrapping viewcontrollers with a uinavigation controller.
    //
    class func buildNavigationControllers() -> [UIViewController] {

        // Featured
        let landingVC = LandingVC()
        let feedsNC = buildNavigationController(vc:landingVC)
        feedsNC.tabBarItem = tabBarItem(title: "Splash", imageName: "PhotoIcon", selectedImageName: "PhotoIcon", tagIndex: tabBarTag.featured.rawValue)

   
        // 2nd Tab
        let blankVC = UIViewController()
        let blankNC = buildNavigationController(vc:blankVC)
        blankNC.tabBarItem = tabBarItem(title: "Apple", imageName: "AppleIcon", selectedImageName: "AppleIcon", tagIndex: tabBarTag.network.rawValue)

        
        // Mapper
        let mapVC = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: "MapViewControllerId")
        mapVC.title = "Map"
        let mapNC = buildNavigationController(vc:mapVC)
        mapNC.tabBarItem = tabBarItem(title: "Map", imageName: "GlobeIcon", selectedImageName: "GlobeIcon", tagIndex: tabBarTag.network.rawValue)


        return  [feedsNC,blankNC,mapNC]
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
  
    



    

    
  
}




