
import Foundation
import UIKit

let kFlikrLoaded = NSNotification.Name("kFlikrLoaded")

class Notificator {
    static func fireNotification(_ named: NSNotification.Name) {
        NotificationCenter.default.post(name: named, object: nil)
    }
}
