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
    weak var weakLandingNC:MyNavigationController?
   
    
    var networkChannels: [Channel] = []
    
    func populateData(){
        
        
        var photos:[Photo] = []
        let photo = Photo(id:1,title:"test",photoDescription:"test",thumbURL:"https://www.90daykorean.com/wp-content/uploads/2017/08/bigstock-184859833.jpg")
        photos.append(photo)
        
        let photo2 = Photo(id:2,title:"test 2",photoDescription:"test",thumbURL:"https://www.90daykorean.com/wp-content/uploads/2017/08/bigstock-184859833.jpg")
        photos.append(photo2)
        
        let photo3 = Photo(id:3,title:"test 3",photoDescription:"test",thumbURL:"https://www.90daykorean.com/wp-content/uploads/2017/08/bigstock-184859833.jpg")
        photos.append(photo3)
        let photo4 = Photo(id:4,title:"test 4",photoDescription:"test",thumbURL:"https://www.90daykorean.com/wp-content/uploads/2017/08/bigstock-184859833.jpg")
        photos.append(photo4)
        
        let channel = Channel(name:"First",photos:photos)
        networkChannels.append(channel)
        let channel2 = Channel(name:"Second",photos:photos)
        networkChannels.append(channel2)
        let channel3 = Channel(name:"Third",photos:photos)
        networkChannels.append(channel3)
        
    }


}
