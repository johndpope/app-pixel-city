//
//  Models.swift
//  pixel-city
//
//  Created by Pope, John on 10/25/18.

import Foundation
import CodableAlamofire


public struct Channel {
    var name:String
    var photos:[MyPhoto]
    
}

public struct FlikrChannel {
    var name:String
    var photos:[Photo]
    
}


public struct MyPhoto:Decodable{

    var id: Int
    var title: String
    var photoDescription: String
    var thumbURL: String


}
class Photo:Codable{
    
    
    //    "id": "39237459520",
    //    "owner": "33887989@N00",
    //    "secret": "96985d13da",
    //    "server": "886",
    //    "farm": 1,
    //    "title": "DSC01997",
    //    "ispublic": 1,
    //    "isfriend": 0,
    //    "isfamily": 0
    
    
    var id:String?
    var owner:String?
    var secret:String?
    var server:String?
    var farm:Double?
    var title:String?
    var ispublic:Double?
    var isfriend:Double?
    var isfamily:Double?
    
    var url:URL{
        let farm = String.init(describing: Int.init((self.farm!)))
        let server = self.server!
        let id = self.id!
        let secret = self.secret!
        let urlStr = "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
        return URL.init(string: urlStr)!
    }
    
    
}

struct PicCollection:Decodable{
    var photos:FlikrResult
    var stat:String
}

struct FlikrResult: Decodable {
    
    var page:Double?
    var pages:Double?
    var perpage:Double?
    var total:String?
    var photo:[Photo]?
    

}

