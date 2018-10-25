import Foundation

class CustomURLCache: URLCache {
    
    // UserInfo expires key
    let kUrlCacheExpiresKey = "CacheData"
    
    // How long is cache data valid in seconds, in 6 hours
    let kCacheExpireInterval: TimeInterval = 60 * 60 * 6
    
    // open func cachedResponse(for request: URLRequest) -> CachedURLResponse?
    // get cache response for a request
    override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        // func cachedResponseForRequest(request:NSURLRequest) -> CachedURLResponse? {
        // create empty response
        var response: CachedURLResponse?
        
        // try to get cache response
        if let cachedResponse = super.cachedResponse(for: request as URLRequest) {
            
            // try to get userInfo
            if let userInfo = cachedResponse.userInfo {
                
                // get cache date
                if let cacheDate = userInfo[kUrlCacheExpiresKey] as! NSDate? {
                    
                    // check if the cache data are expired
                    if cacheDate.timeIntervalSinceNow < -kCacheExpireInterval {
                        // remove old cache request
                        removeCachedResponse(for: request as URLRequest)
                    } else {
                        // the cache request is still valid
                        response = cachedResponse
                    }
                }
            }
        }
        
        return response
    }
    
    // store cached response
    override func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        // func storeCachedResponse(cachedResponse: CachedURLResponse, forRequest: NSURLRequest) {
        // create userInfo dictionary
        
        var userInfo = [AnyHashable: Any]()
        
        // if let cachedUserInfo = cachedResponse.userInfo {
        // userInfo = NSMutableDictionary(dictionary:cachedUserInfo)
        // }
        // add current date to the UserInfo
        userInfo[kUrlCacheExpiresKey] = NSDate()
        
        // create new cached response
        // TODO: fix the userInfo type mismatch
        let newCachedResponse = CachedURLResponse(response: cachedResponse.response, data: cachedResponse.data, userInfo: userInfo, storagePolicy: cachedResponse.storagePolicy)
        super.storeCachedResponse(newCachedResponse, for: request as URLRequest)
    }
}
