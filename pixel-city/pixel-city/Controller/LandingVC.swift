import Foundation
import UIKit
import Material
import CocoaLumberjack

class LandingVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var selectedIndex:Int = 0
    let footerHeight:CGFloat = 80
    
    lazy var myTableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        return tb
    }()

    var featuredTableHeader = FeaturedTableViewHeader()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "🦒 Landing"
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .white
        view.addSubview(myTableView)
        myTableView.backgroundColor = UIColor.onyx
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myTableView.separatorStyle = .none
        myTableView.register(NetworkLandingCell.self, forCellReuseIdentifier: NetworkLandingCell.ID)
        myTableView.tableFooterView = UITableViewHeaderFooterView(frame:CGRect(x:0,y:0,width:1,height:footerHeight))
        
        
        // Header image
        myTableView.tableHeaderView = featuredTableHeader
        
        // demo header
        let photo = Photo(id: 1, title: "Good night Gorilla", photoDescription: "bla bla", thumbURL: "https://www.underthemoonlightsg.com/uploads/1/0/8/8/108893287/s498573774969902924_p179_i2_w685.jpeg")
        featuredTableHeader.configureHeader(photo: photo)
        
        myTableView.dataSource = self
        myTableView.delegate = self
        reloadTableView()
        configureConstraints()
    }


  
    
     // Snapkit layouts
    func configureConstraints(){
        myTableView.snp.remakeConstraints { (make) -> Void in
            make.width.height.top.equalToSuperview()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // call this to allow emoji in this title - but not in navigation items
         MyTabBar.resyncTabBarTitles()
    }



    func reloadTableView() {
        myTableView.reloadData()
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}
