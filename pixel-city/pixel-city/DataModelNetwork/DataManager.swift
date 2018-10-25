import UIKit
import Alamofire
import CocoaLumberjack




let DM = DataManager.shared



class DataManager {

    static let shared = DataManager()
    weak var weakWindow: UIWindow?
    weak var weakLandingNC:MyNavigationController?
   
    
    var networkChannels: [Channel] = []
    
    
    var flikrChannels: [FlikrChannel] = []

    func populateData(){
        
        
        var photos:[MyPhoto] = []
        let photo = MyPhoto(id:1,title:"test",photoDescription:"test",thumbURL:"https://i.ytimg.com/vi/MVpGyBYelF8/hqdefault.jpg")
        photos.append(photo)
        
        let photo2 = MyPhoto(id:2,title:"test 2",photoDescription:"test",thumbURL:"https://ih1.redbubble.net/image.125582096.7215/flat,550x550,075,f.u1.jpg")
        photos.append(photo2)
        
        let photo3 = MyPhoto(id:3,title:"test 3",photoDescription:"test",thumbURL:"https://i.ytimg.com/vi/MVpGyBYelF8/hqdefault.jpg")
        photos.append(photo3)
        let photo4 = MyPhoto(id:4,title:"test 4",photoDescription:"test",thumbURL:"https://i.ytimg.com/vi/MVpGyBYelF8/hqdefault.jpg")
        photos.append(photo4)
        
        let channel = Channel(name:"New Favorites",photos:photos)
        networkChannels.append(channel)
        let channel2 = Channel(name:"Second",photos:photos)
        networkChannels.append(channel2)
        let channel3 = Channel(name:"Third",photos:photos)
        networkChannels.append(channel3)
        
    }


}
