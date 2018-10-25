
import Foundation
import UIKit

let kPlaceholderImage = UIImage(named: "placeholder")


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
let FLICKR_API_NUMBER_OF_PHOTOS: String = "40"

func flickrUrl(withAnnotation annotation: DroppablePin) -> String {
    
//    https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=1897b92eff5568083a3ec0b1349385f4&lat=49.86&lon=-97.27&radius=1&radius_units=km&per_page=40&format=json&nojsoncallback=1

    let latitude = annotation.coordinate.latitude
    let longitude = annotation.coordinate.longitude
    let apiURL = "\(FLICKR_API_BASE_URL)?method=\(FLICKR_API_METHOD)&api_key=\(FLICKR_API_KEY)&lat=\(latitude)&lon=\(longitude)&radius=\(FLICKR_API_RADIOUS)&radius_units=\(FLICKR_API_RADIOUS_UNITS)&per_page=\(FLICKR_API_NUMBER_OF_PHOTOS)&format=\(FLICKR_API_FORMAT)&nojsoncallback=1"
    
    // print(apiURL)
    return apiURL
}


var screenWidth = UIScreen.main.bounds.width
var screenHeight = UIScreen.main.bounds.height

//All views which constraints are based on device's width/height needs to refer to this
struct currentSize {
    static var height : CGFloat = screenHeight
    static var width : CGFloat = screenWidth
    
    static func updateCurrentSize(size: CGSize) {
        currentSize.height = size.height
        currentSize.width = size.width
        
    }
    
    static func getCurrentSize() -> CGSize {
        return CGSize(width: currentSize.width, height: currentSize.height)
    }
}
