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

    
    func fetchLandingContent(){
        searchFlickrForTerm("gorilla") { (photos, error)  in
            print("photos:",photos)
        }
        searchFlickrForTerm("giraffe") { (photos, error)  in
             print("photos:",photos)
        }
        searchFlickrForTerm("armadillo") { (photos, error)  in
            print("photos:",photos)
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


