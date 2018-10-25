import UIKit
import Alamofire
import CocoaLumberjack
import UnboxedAlamofire
import Unbox
import AVFoundation



let DM = DataManager.shared



class DataManager {

    static let shared = DataManager()
    weak var weakWindow: UIWindow?
    
    var networkTopNavChannels: [Channel] = []
    var networkChannels: [Channel] = []


}
