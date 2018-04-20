//
//  Constants.swift
//  pixel-city
//
//  Created by David Brunstein on 2018-04-18.
//  Copyright © 2018 David Brunstein. All rights reserved.
//

import Foundation


// Map and Annotations
let PIN_IDENTIFIER: String = "droppablePin"
let REGION_ZOOM: Double = 2.0


// Flickr API - https://www.flickr.com/services/apps/create/noncommercial/?
// https://www.flickr.com/services/api/explore/flickr.photos.search
let FLICKR_API_KEY: String = "75b30c6507dde8e65d74fad86160ac98"
let FLICKR_API_BASE_URL: String = "https://api.flickr.com/services/rest/"
let FLICKR_API_METHOD: String = "flickr.photos.search"
let FLICKR_API_RADIOUS: String = "1"
let FLICKR_API_RADIOUS_UNITS: String = "km"
let FLICKR_API_FORMAT: String = "json"

func flickrUrl(withAnnotation annotation: DroppablePin, andNumberOfPhotos numberOfPhotos: Int) -> String {
    
//    https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=1897b92eff5568083a3ec0b1349385f4&lat=49.86&lon=-97.27&radius=1&radius_units=km&per_page=40&format=json&nojsoncallback=1

    let latitude = annotation.coordinate.latitude
    let longitude = annotation.coordinate.longitude
    let apiURL = "\(FLICKR_API_BASE_URL)?method=\(FLICKR_API_METHOD)&api_key=\(FLICKR_API_KEY)&lat=\(latitude)&lon=\(longitude)&radius=\(FLICKR_API_RADIOUS)&radius_units=\(FLICKR_API_RADIOUS_UNITS)&per_page=\(numberOfPhotos)&format=\(FLICKR_API_FORMAT)&nojsoncallback=1"
    
    // print(apiURL)
    return apiURL
}


