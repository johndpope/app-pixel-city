import Foundation
import CocoaLumberjack
import SDWebImage

extension UIImageView {

    func loadImageUsingCacheWithUrlString(urlString: String) {
        loadImageUsingCacheWithUrlString(urlString: urlString, noFadeIn: false)
    }

    func loadImageUsingCacheWithUrlString(urlString: String, noFadeIn: Bool, placeholderImage: UIImage?,networkImageContentMode:UIViewContentMode?) {
        
        image = placeholderImage
        
        if urlString.lowercased().range(of: "http") == nil {
            print("🔥 FATAL - url invalid:" + urlString)
            return
        }

       
        SDWebImageManager.shared().loadImage(with: URL(string: urlString), options: [], progress: nil, completed: { image, _, error, _, _, _ in
            if let error = error {
                DispatchQueue.main.async {
                    self.image = kPlaceholderImage
                    self.setNeedsDisplay()
                }
                
                print(error.localizedDescription)
                return
            }
            
            
            if !noFadeIn {
                UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.image = image
                }, completion: nil)
            } else {
                self.image = image
            }
            
            if let contentMode = networkImageContentMode {
                self.contentMode = contentMode
            }
        })
    }

    func loadImageUsingCacheWithUrlString(urlString: String, noFadeIn: Bool) {
        loadImageUsingCacheWithUrlString(urlString: urlString, noFadeIn: noFadeIn, placeholderImage: nil, networkImageContentMode: nil)
    }
    
    func setImage(urlString: String, withFadeIn: Bool = true) {
        guard !urlString.isEmpty else { return }
        guard urlString != "None" else { return }
        guard let url = URL(string: urlString) else { return }
        
        if withFadeIn {
            SDImageCache.shared().diskImageExists(withKey: urlString) { isExist in
                if isExist {
                    self.sd_setImage(with: url)
                } else {
                    self.sd_setImage(with: url, placeholderImage: kPlaceholderImage, options: .avoidAutoSetImage) { (downloadedImage, error, _, _) in
                        
                        guard error == nil else {
                            print("👀 Could not download image from: " + urlString)
                            return
                        }
                        
                        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
                            self.image = downloadedImage
                        }, completion: nil)
                    }
                }
            }
        } else {
            self.sd_setImage(with: url, placeholderImage: kPlaceholderImage, options: .scaleDownLargeImages)
        }
    }
    
}
