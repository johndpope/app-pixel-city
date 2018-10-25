import UIKit
import Alamofire
import CocoaLumberjack
import CodableAlamofire



let kPaginationLoad : Int = 10

class APIManager {
    static let shared = APIManager()
    static let memoryCapacity = 500 * 1024 * 1024
    static let diskCapacity = 500 * 1024 * 1024
    static let sharedInstance = APIManager()
    static  let cache = CustomURLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "Cache-01")
    
    var manager: Alamofire.SessionManager

    init() {

        let configuration = URLSessionConfiguration.default
        let defaultHeaders = Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders ?? [:]

        configuration.httpAdditionalHeaders = defaultHeaders
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = APIManager.cache

        let baseAPIURL: NSURL = NSURL(string: FLICKR_API_BASE_URL)!

        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            baseAPIURL.host!: .disableEvaluation,
        ]

        let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)

        // TODO: Need to find a way to plug in expiration parameter
        manager = Alamofire.SessionManager(configuration: configuration, serverTrustPolicyManager: serverTrustPolicyManager)
        
    }

    
    // Why this? - this is crafting multiple API calls to get variety of results to mash together into landing page
    // It's possible to eagerly fetch this content before any views appear - so we use lose coupling to broadcast when data comes in
    // optimisations could include reducing number of images to fetch
    func fetchLandingContent(){
        
        
        let gorillaTitle = "Gorilla"
        searchFlickrForTerm(gorillaTitle) { (photos, error)  in

            let channel = FlikrChannel(name: gorillaTitle, photos: photos)
            DM.flikrChannels.append(channel)
            Notificator.fireNotification(kFlikrLoaded)
        }
 
       
        let giraffeTitle = "Giraffe"
        searchFlickrForTerm(giraffeTitle) { (photos, error)  in
  
            let channel = FlikrChannel(name: giraffeTitle, photos: photos)
            DM.flikrChannels.append(channel)
            Notificator.fireNotification(kFlikrLoaded)
           
        }
        
        
        let armadilloTitle = "Armadillo"
        searchFlickrForTerm(armadilloTitle) { (photos, error)  in
            let channel = FlikrChannel(name: armadilloTitle, photos: photos)
            DM.flikrChannels.append(channel)
            Notificator.fireNotification(kFlikrLoaded)
        }
        
        
        let lionTitle = "Lion"
        searchFlickrForTerm(lionTitle) { (photos, error)  in
            let channel = FlikrChannel(name: lionTitle, photos: photos)
            DM.flikrChannels.append(channel)
            Notificator.fireNotification(kFlikrLoaded)
        }
        
        let elephantTitle = "Elephant"
        searchFlickrForTerm(elephantTitle) { (photos, error)  in
            let channel = FlikrChannel(name: elephantTitle, photos: photos)
            DM.flikrChannels.append(channel)
            Notificator.fireNotification(kFlikrLoaded)
        }
        
        
    }
    
    func searchFlickrForTerm(_ searchText:String, completion:@escaping (_ photos: [Photo], _ error: NSError?) -> ()){
        let searchUrl = "\(FLICKR_API_BASE_URL)?method=\(FLICKR_API_METHOD)&api_key=\(FLICKR_API_KEY)&per_page=\(FLICKR_API_NUMBER_OF_PHOTOS)&format=\(FLICKR_API_FORMAT)&nojsoncallback=1&safe_search=1&text="
        
        let urlStr = "\(searchUrl)\(searchText)"
 
        
        manager.request(urlStr).responseDecodableObject { (response: DataResponse<PicCollection>) in

            switch response.result {
            case .success(let result):
                if let myPhotos = result.photos.photo{
                    completion(myPhotos,nil)
                }else{
                      completion([],nil)
                }

            case .failure(let error):
                  completion([],error as NSError)
            }

        }

        
    }
    

   
    
   
    
}


