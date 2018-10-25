import Foundation
import UIKit
import SnapKit
import Material
import CocoaLumberjack
import Alamofire





// This is a collectionview nested inside a uitableview cell.

class NetworkLandingCell: TableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    static let ID = "NetworkLandingCell"

    let cellLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    public var networkCV: UICollectionView?


    var paginationIndex: Int = 0
    var itemsList: [MyPhoto] = []
    var item: Channel?

    override func prepareForReuse() {
        super.prepareForReuse()
        buildCollectionView()
    }
    
    func buildCollectionView(){
        if networkCV != nil {
            networkCV!.removeFromSuperview()
        }
        networkCV = UICollectionView(frame: .zero, collectionViewLayout: cellLayout)
        networkCV?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        networkCV?.showsVerticalScrollIndicator = false
        networkCV?.showsHorizontalScrollIndicator = false
        networkCV?.isScrollEnabled = true
        networkCV?.bounces = true
        networkCV?.delegate = self
        networkCV?.dataSource = self
        networkCV?.backgroundColor = UIColor.onyx
        networkCV?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.ID)
        if let cv = networkCV {
            contentView.addSubview(cv)
        }
        cellLayout.scrollDirection = .horizontal
        cellLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        pulseAnimation = .none
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        buildCollectionView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        networkCV?.snp.remakeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(self.snp.width).offset(0)
            make.height.equalTo(VM.networkCellSize.height)
        }
    }
    
    // MARK: - UICollectionViewDataSource

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return itemsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.ID, for: indexPath) as! VideoCollectionViewCell

        if itemsList.count > 0 {
            let video = itemsList[indexPath.row]

            cell.configureCollectionViewCell(video: video)
        }
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("didSelectItemAt")
        let vc = UIViewController()
        vc.title = "🦒 Detail Page"
        DM.weakLandingNC?.pushViewController(vc, animated: true)
    }

    // MARK: - UICollectionViewDelegate
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return VM.networkCellSize
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 10
    }

    func configureTableViewCell(photos: [MyPhoto]) {

        cellLayout.itemSize = VM.networkCellSize
        itemsList = photos
        setNeedsLayout()
        networkCV?.reloadData()
    }

    func configureTableViewCellWithPhotos(channel:Channel,photos: [MyPhoto]) {
        
        cellLayout.itemSize = VM.networkCellSize
        item = channel
        itemsList = photos
        setNeedsLayout()
        networkCV?.reloadData()
        
    }

    func refreshContent() {
        paginationIndex = 0
        itemsList.removeAll()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
