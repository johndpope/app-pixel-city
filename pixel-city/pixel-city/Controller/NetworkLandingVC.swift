import Foundation
import UIKit
import Material
import CocoaLumberjack


/*
class NetworkLandingVC: UIViewController, UITableViewDelegate {


    var channel: Channel?


    lazy var myTableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        return tb
    }()

    var bRunOnceOnLoad = false
    
    override func loadView() {
        super.loadView()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }


    @objc func refreshContent() {
        print("App config changed!")
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init() {
        super.init(nibName: nil, bundle: nil)

        channelIndex = 0

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .white

        // Snapkit layouts
        view.addSubview(myTableView)
        myTableView.backgroundColor = .onyx
        myTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myTableView.snp.remakeConstraints { (make) -> Void in
            make.width.height.top.left.equalToSuperview()
        }

        populateData()
        buildNetworkData()

        view.backgroundColor = .clear
    }
    
    func buildNetworkData() {
        for channel in DM.networkChannels{
            self.dataSource?.fetchItemsList(channel:channel)
        }
    }




    func populateData() {
        dataSource = NetworkLandingDataSource(tableView: myTableView, parentViewController: self)
        myTableView.dataSource = dataSource
        myTableView.delegate = dataSource
        myTableView.reloadData()
    }

    // MARK: - XLTabStrip - IndicatorInfoProvider
    func indicatorInfo(for _: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
*/
