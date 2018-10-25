import UIKit
import Alamofire
import CocoaLumberjack
import Device

let VM = VisualManager.shared
let iPad = Device.isPad()
let iPadPro = Device.size() == .screen12_9Inch
let iPadMini = Device.size() == .screen7_9Inch



// target different layouts for differet devices.
// support rotation

class VisualManager {
    
    static let shared = VisualManager()
    
    var networkCellSize:CGSize{
        if iPad{
            if iPadMini{
                return CGSize(width: 237, height: 210)
            }
            
            return CGSize(width: 316, height: 240)
            
        }
        
        return CGSize(width: 160, height: 144 + 10)
    }
    

    var minimumInteritemSpacing:CGFloat{
        return 3
    }
    
}



// WARNING -
// dimensions may need to cater for landscape too.
struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the LandScape orientation
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
}}
