import Foundation
import UIKit
import SnapKit
import Material
import CocoaLumberjack



class HeaderSection: UIView {
    var headerLabel = UILabel(frame: .zero)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    public convenience init(sectionName: String, sectionTitleHeight: CGFloat) {
        self.init(sectionName: sectionName, sectionTitleHeight: sectionTitleHeight, color: UIColor.onyx, offset: 0, showSeparator: true)
    }

    public convenience init(sectionName: String, sectionTitleHeight: CGFloat, color: UIColor, offset: CGFloat, showSeparator: Bool) {
        self.init()
        
        self.isUserInteractionEnabled = false
        backgroundColor = color

        
        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy)
        headerLabel.textColor = .white
        addSubview(headerLabel)
        headerLabel.text = sectionName
        headerLabel.textColor = .white
        headerLabel.text = sectionName
        headerLabel.snp.remakeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(10 + offset)
            make.height.equalTo(sectionTitleHeight)
            make.width.equalTo(self.snp.width)
            make.centerY.equalToSuperview()
        }

        let separatorView = UIView(frame: .zero)
        addSubview(separatorView)
        separatorView.backgroundColor = UIColor.darkLine
        separatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        separatorView.snp.remakeConstraints { (make) -> Void in
            // make.left.equalToSuperview().offset(10 )
            make.height.equalTo(1)
            make.width.equalTo(self.snp.width).offset(-20)
            make.bottom.equalToSuperview().offset(-1)
            make.centerX.equalToSuperview()
        }
        separatorView.isHidden = !showSeparator
    }

    func toggleExpand() {
        print("toggleExpand")
    }
}
