import UIKit
import Alamofire
import CocoaLumberjack
import UnboxedAlamofire
import Unbox



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

    

   
    /*
    // Service accepts both the superstar id from VMS, or the WWEID from Drupal
    func fetchSuperstarAssociatedContent(superstarIDorWWEID: String, paginationIndex : Int, completion: @escaping (AssociatedContent) -> Void) {
        
        var urlStr = API_URL() + API_GET_SUPERSTAR_CONTENT + "/\(superstarIDorWWEID)"
        urlStr = urlStr + "/pagination/" + String((paginationIndex * 10)) + "," + String(kPaginationLoad)
        
        DDLogInfo("\nAPIManager.fetchSuperstarAssociatedContent(\(urlStr))\n================")

        manager.request(urlStr, method: .get).responseArray { (response: DataResponse<[WWEContentGroup]>) in
            
            if let error = response.result.error as? UnboxedAlamofireError {
                DDLogError("unbox error:\(error.description)  url:\(urlStr)")
                DDLogVerbose("debug:" + String(describing: response.result.value))
            }
            
            if let contentGroups = response.result.value {
                let filteredContentGroups = contentGroups.filter { $0.groupType == "video" || $0.groupType == "show" || $0.groupType == "superstar" }
                let ac = AssociatedContent(contentId: superstarIDorWWEID, contentGroups: filteredContentGroups)
                DDLogVerbose("ac:" + String(describing: ac))
                // DEBUG
                var hasVideos = false
                for group in ac.contentGroups{
                    if let videos = group.videos{
                        if (videos.count > 0){
                            hasVideos = true
                        }
                    }
                }
                if !hasVideos{
                    DDLogWarn("⛑ No videos returned from api!!!!")
                }
                
                completion(ac)
            }
        }
    }*/
    
}


