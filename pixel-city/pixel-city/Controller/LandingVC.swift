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
        myTableView.tableHeaderView = DebugView.emptyTableHeaderView()
        
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
