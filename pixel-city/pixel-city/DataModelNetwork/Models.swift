//
//  Models.swift
//  pixel-city
//
//  Created by Pope, John on 10/25/18.

import Foundation
import Unbox
import UnboxedAlamofire


public struct Channel: Unboxable {
    var name:String
    public init(unboxer: Unboxer) throws {
        name = try unboxer.unbox(key: "name")
    }
    
}

public struct Photo: Unboxable {
    public init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "id")
        eventDate = try unboxer.unbox(key: "eventDate")
        title = try unboxer.unbox(key: "title")
        photoDescription = try unboxer.unbox(key: "photoDescription")
        thumbURL = try unboxer.unbox(key: "thumbURL")
        
    }
    
    var id: Int
    var eventDate: String
    var title: String
    var photoDescription: String
    var thumbURL: String


    init() {
        id = 0
        eventDate = ""
        title = ""
        photoDescription = ""
        thumbURL = ""

    }
    

    
    
}
