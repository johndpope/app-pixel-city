//
//  Models.swift
//  pixel-city
//
//  Created by Pope, John on 10/25/18.

import Foundation
import Unbox
import UnboxedAlamofire


public struct Channel {
    var name:String
    var photos:[Photo]
    
}

public struct Photo{//} : Unboxable {
//    public init(unboxer: Unboxer) throws {
//        id = try unboxer.unbox(key: "id")
//        eventDate = try unboxer.unbox(key: "eventDate")
//        title = try unboxer.unbox(key: "title")
//        photoDescription = try unboxer.unbox(key: "photoDescription")
//        thumbURL = try unboxer.unbox(key: "thumbURL")
//
//    }
    
    var id: Int
    var title: String
    var photoDescription: String
    var thumbURL: String



    
    
}
