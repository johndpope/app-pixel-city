import Foundation
import UIKit
import SnapKit
import Material
import CocoaLumberjack
import Device




extension VideoCollectionViewCell {
    
    
    func configureConstraints(){
        heroImageView.snp.remakeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(88)
        }
        
        videoLabel.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(self.heroImageView.snp.bottom).offset(10)
            make.width.equalTo(130)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(10)
        }
        
        
        progressView.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(self.heroImageView.snp.width)
            make.bottom.equalTo(self.heroImageView.snp.bottom)
            make.left.equalToSuperview()
            make.height.equalTo(5)
        }
        
        alphaDurationView.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(37)
            make.height.equalTo(18)
            make.bottom.equalTo(self.heroImageView).offset(-9)
            make.right.equalTo(self.heroImageView).offset(-7)
        }
        
        durationLabel.snp.remakeConstraints { (make) -> Void in
            make.centerY.equalTo(self.alphaDurationView.snp.centerY)
            make.centerX.equalTo(self.alphaDurationView.snp.centerX)
        }
        
        dateLabel.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(self.videoLabel.snp.bottom).offset(0)
            make.height.equalTo(25)
            make.left.equalTo(0).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    
    func configureTabletConstraints(){
        heroImageView.snp.remakeConstraints { (make) -> Void in
            make.top.left.equalTo(0)
            make.width.equalTo(VM.networkCellSize.width)
            make.height.equalTo( 178 )
        }
        
        videoLabel.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(self.heroImageView.snp.bottom).offset(10)
            make.left.equalTo(0).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(10)
        }
        
        
        progressView.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(self.heroImageView.snp.width)
            make.bottom.equalTo(self.heroImageView.snp.bottom)
            make.left.equalToSuperview()
            make.height.equalTo(5)
        }
        
        alphaDurationView.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(37)
            make.height.equalTo(18)
            make.bottom.equalTo(self.heroImageView).offset(-9)
            make.right.equalTo(self.heroImageView).offset(-7)
        }
        
        durationLabel.snp.remakeConstraints { (make) -> Void in
            make.centerY.equalTo(self.alphaDurationView.snp.centerY)
            make.centerX.equalTo(self.alphaDurationView.snp.centerX)
        }
        
        dateLabel.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(self.videoLabel.snp.bottom).offset(0)
            make.height.equalTo(25)
            make.left.equalTo(0).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    
    
}

