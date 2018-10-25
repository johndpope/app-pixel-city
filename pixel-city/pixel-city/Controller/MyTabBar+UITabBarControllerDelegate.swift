import Foundation
import UIKit

extension MyTabBar: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect _: UIViewController) {
        print("OK")
        MyTabBar.resyncTabBarTitles()
    }
}
