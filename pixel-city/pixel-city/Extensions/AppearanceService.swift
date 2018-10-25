import Foundation
import UIKit
import Material

// Base appearance protocol
protocol AppearanceProtocol {
    var tintColor: UIColor { get }
    var unselectedTintColor: UIColor? { get }
    var barTintColor: UIColor? { get }
    var isTranslucent: Bool { get }
}

// Status appearance protocol & struct
protocol StatusBarAppearanceProtocol: AppearanceProtocol {}
extension StatusBarAppearanceProtocol {
    var tintColor: UIColor { return UIColor.white }
    var unselectedTintColor: UIColor? { return nil }
    var barTintColor: UIColor? { return .cyan }
    var isTranslucent: Bool { return false }
}

struct StatusBarAppearance: NavigationBarAppearanceProtocol {}

// Navigation appearance protocol & struct
protocol NavigationBarAppearanceProtocol: AppearanceProtocol {}
extension NavigationBarAppearanceProtocol {
    var tintColor: UIColor { return .white }
    var unselectedTintColor: UIColor? { return .yellow }
    var barTintColor: UIColor? { return UIColor.clear }
    var isTranslucent: Bool { return false }
}

struct NavigationBarAppearance: NavigationBarAppearanceProtocol {}

// TabBar appearance protocol & struct
protocol TabBarAppearanceProtocol: AppearanceProtocol {}
extension TabBarAppearanceProtocol {
    var tintColor: UIColor { return .white }
    var unselectedTintColor: UIColor? { return UIColor(white: 1, alpha: 0.7) }
    var barTintColor: UIColor? { return .yellow }
    var isTranslucent: Bool { return true }
}

struct TabBarAppearance: TabBarAppearanceProtocol {}


struct Skin {
    var primaryColor:String
    var darkPrimaryColor:String
    var lightPrimaryColor:String
    var textColor:String
    var primaryText:String
    var secondaryText:String
    var dividerColor:String
    var backgroundColor:String
}


final class AppearanceService {
    static let shared = AppearanceService()

    let statusBar = StatusBarAppearance()
    let navBar = NavigationBarAppearance()
    let tabBar = TabBarAppearance()

    var currentSkin: Skin!
    
    init() {
        //TODO: review and complete with correct colors.
        currentSkin = Skin(primaryColor: "#",
                           darkPrimaryColor: "#C7BFBF",
                           lightPrimaryColor: "",
                           textColor: "#",
                           primaryText: "#",
                           secondaryText: "#121212",
                           dividerColor: "#292929",
                           backgroundColor: "121212"
                            )
    }
    
    func setGlobalAppearance() {
        
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.statusBarBackgroundColor = .black
        
        //iPhoneX large navigation titles
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white,
             NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.medium)]
        
        // NavigationBar
        let navAppearance = UINavigationBar.appearance()
        navAppearance.tintColor = navBar.tintColor
        navAppearance.barTintColor = navBar.barTintColor
        navAppearance.isTranslucent = navBar.isTranslucent
        navAppearance.titleTextAttributes = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium),
            
            NSAttributedStringKey.foregroundColor: UIColor.white,
        ]

        // Switch
         let switchAppearance = UISwitch.appearance()
        switchAppearance.onTintColor = UIColor.governorBay
        switchAppearance.thumbTintColor = .white
        switchAppearance.backgroundColor = UIColor.grayChateau
        switchAppearance.tintColor = UIColor.grayChateau
        switchAppearance.layer.cornerRadius = 16
        
        
        // Text fields
        let searchAppearance = UISearchBar.appearance()
        searchAppearance.backgroundColor = UIColor.blackButtonColor
        searchAppearance.tintColor = UIColor.governorBay
        searchAppearance.barTintColor = .white
        searchAppearance.searchBarStyle = .minimal

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)

        // UITabBar
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = .clear
        tabBarAppearance.tintColor = .governorBay
        tabBarAppearance.isTranslucent = tabBar.isTranslucent
        
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.light),
            NSAttributedStringKey.foregroundColor: UIColor.white,
        ], for: .disabled)
        UITabBarItem.appearance().setTitleTextAttributes(
            [
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.semibold),
                NSAttributedStringKey.foregroundColor: UIColor.white,
        ], for: .selected)

        // UITabBar
        if #available(iOS 10.0, *) {
            tabBarAppearance.unselectedItemTintColor = tabBar.unselectedTintColor
        } else {
            // Fallback on earlier versions
        }
        
        
        // UISlider
        UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), for: UIControlState())
        
        // left / right navigation buttons
        UIBarButtonItem.appearance().tintColor = .white
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.light),
                NSAttributedStringKey.foregroundColor: UIColor.white,
        ], for: .normal)

        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.light),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray,
        ], for: .disabled)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes(
            [
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.light),
                NSAttributedStringKey.foregroundColor: UIColor.lightGray,
        ], for: .normal)

        // StatusBar
        UIApplication.shared.statusBarStyle = .lightContent
        guard let statusView = UIApplication.shared.value(forKey: "statusBar") as? UIView else {
            return
        }
        statusView.backgroundColor = statusBar.barTintColor
    }

    // TODO - iphone X sits the red line too far down.
    func redlineImageWithColorPosition() -> UIImage {
        let color = UIColor.governorBay
        let lineSize = CGSize(width: currentSize.width / 5, height: 2)
        let size = CGSize(width: currentSize.width / 5, height: 49)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        // the redline
        let rectLine = CGRect(x: 7.5, y: size.height - lineSize.height, width: lineSize.width - 15, height: lineSize.height)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.setFill()
        UIRectFill(rect)
        color.setFill()
        UIRectFill(rectLine)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    class func setBarButtonItemAppearance() {
    }
}

//MARK: - Skinnable
protocol Skinnable {
}

extension Skinnable {
    
    func skinPrimaryColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: AppearanceService.shared.currentSkin.primaryColor)
    }
    
    func skinDarkPrimaryColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: AppearanceService.shared.currentSkin.darkPrimaryColor)
    }
    
    func skinLightPrimaryColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: AppearanceService.shared.currentSkin.lightPrimaryColor)
    }
    func skinTextColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: AppearanceService.shared.currentSkin.textColor)
    }
    
    func skinPrimaryTextColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: AppearanceService.shared.currentSkin.primaryText)
    }
    
    func skinSecondaryTextColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: AppearanceService.shared.currentSkin.secondaryText)
    }
    
    func skinDividerColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: AppearanceService.shared.currentSkin.dividerColor)
    }
    
    func skinBackgroundColor() -> UIColor {
        return UIColor.hexStringToUIColor(hex: AppearanceService.shared.currentSkin.backgroundColor)
    }
    
}

extension UIView: Skinnable {
    func skinViewLabels() {
        skinViewLabels(color: skinTextColor())
    }
    func skinViewLabels(color:UIColor) {
        for view in self.subviews {
            if type(of: view) == UILabel.self {
                let label = view as! UILabel
                label.textColor = color
            }
        }
    }
}
