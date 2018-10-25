import Foundation
import UIKit
import SnapKit
import Material
import CocoaLumberjack
import Device


// This handles the TableViewCell for most video use cases.
// Use func configureCell(item:Photo) to modify state


class VideoCollectionViewCell: CollectionViewCell {
    static let ID = "VideoCollectionViewCell"


    lazy var alphaDurationView: UIView = {
        let iv = UIView(frame: .zero)
        return iv
    }()

    lazy var heroImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = kPlaceholderImage
        return iv
    }()

    lazy var progressView: UIProgressView = {
        let p = UIProgressView(frame: .zero)
        p.progressViewStyle = .bar
        p.clipsToBounds = true
        p.progressTintColor = UIColor.fireEngineRed
        p.trackTintColor = UIColor(white: 1, alpha: 0.4)
        return p
    }()

    let videoLabel = UILabel(frame: .zero)
    let durationLabel = UILabel(frame: .zero)
    let dateLabel = UILabel(frame: .zero)

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.image = kPlaceholderImage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.jungleGreen

        // Hero Image
        addSubview(heroImageView)
        heroImageView.contentMode = .scaleAspectFit
        heroImageView.clipsToBounds = true
        heroImageView.snp.remakeConstraints { (make) -> Void in
            make.width.height.top.left.equalToSuperview()
        }

        // Progress indicator
        heroImageView.addSubview(progressView)
        let random = arc4random_uniform(100)
        let percent = Float(random) / 100
        progressView.progress = percent

        progressView.isHidden = true

        // Duration alpha box
        heroImageView.addSubview(alphaDurationView)
        alphaDurationView.backgroundColor = .black
        alphaDurationView.alpha = 0.5
      
        // Duration label
        addSubview(durationLabel)
        durationLabel.textColor = .white
        durationLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.medium)
        durationLabel.text = "0:00"
  
        // The default text label
        // This needs to avoid hitting the kebab +
        // and be positioned away from image on left
        addSubview(videoLabel)
        videoLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        videoLabel.text = "blah blah blah"
        videoLabel.textColor = .white
        videoLabel.numberOfLines = 1
        videoLabel.textAlignment = .left
     

        addSubview(dateLabel)
        durationLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.regular)
        dateLabel.text = " August 31 2020"
        dateLabel.textColor = UIColor.rgb(r: 148, g: 145, b: 150)
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .left


    }

    func configureCollectionViewCell(video: Photo) {

        videoLabel.text = video.title
//        dateLabel.text = video.eventDate

        durationLabel.isHidden = false
        alphaDurationView.isHidden = false
        heroImageView.image = kPlaceholderImage
        heroImageView.loadImageUsingCacheWithUrlString(urlString: video.thumbURL, noFadeIn:true)


  
        if iPad{
            configureTabletConstraints()
        }else{
            configureConstraints()
        }
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
