import Foundation
import UIKit
import SnapKit
import Material
import CocoaLumberjack



class FeaturedTableViewHeader: UIView {
    var headerLabel = UILabel(frame: .zero)
    
    lazy var heroImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = kPlaceholderImage
        return iv
    }()
    
    let videoLabel = UILabel(frame: .zero)
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init() {
        let rect = CGRect(x: 0, y: 0, width: screenWidth, height: 200)
        self.init(frame: rect)

        
        self.isUserInteractionEnabled = false
   
        
        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy)
        headerLabel.textColor = .white
        addSubview(headerLabel)
        
        // label
        addSubview(videoLabel)
        videoLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        videoLabel.text = "blah blah blah"
        videoLabel.textColor = .white
        videoLabel.numberOfLines = 1
        videoLabel.textAlignment = .left
        
        
        
        // Hero Image
        addSubview(heroImageView)
        heroImageView.contentMode = .scaleAspectFit
        heroImageView.clipsToBounds = true
        heroImageView.snp.remakeConstraints { (make) -> Void in
            make.width.height.top.left.equalToSuperview()
        }

    }
    func configureHeader(photo: Photo) {
        
        videoLabel.text = photo.title
 
        heroImageView.image = kPlaceholderImage
        heroImageView.loadImageUsingCacheWithUrlString(urlString: photo.thumbURL, noFadeIn:false)


    }
    

    func toggleExpand() {
        print("toggleExpand")
    }
}
