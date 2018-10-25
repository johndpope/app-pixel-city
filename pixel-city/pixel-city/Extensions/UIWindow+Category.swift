
import Foundation
import UIKit

extension UIWindow {
    public class func window() -> UIWindow {
        return UIWindow(frame: UIScreen.main.bounds)
    }
}

extension UIStoryboard {
    class func storyboardNamed(_ name: String, bundle: Bundle = Bundle.main) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    class func chromeCastStoryboard() -> UIStoryboard {
        return storyboardNamed("ChromeCast")
    }
    class func mainStoryboard() -> UIStoryboard {
        return storyboardNamed("Main")
    }
}

extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get { return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor }
        set { (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue } }
}
