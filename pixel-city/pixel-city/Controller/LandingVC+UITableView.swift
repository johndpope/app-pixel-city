import Foundation
import UIKit
import Material
import CocoaLumberjack

extension LandingVC {
  
    
    // MARK: Tableview datasource
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return DM.networkTopNavChannels.count + 1
    }
    
    // TODO: - clean this up
    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellTitle = ""
        
        if indexPath.row == 0 {
            cellTitle = "Home"
        } else {
            let channel = DM.networkTopNavChannels[indexPath.row - 1]
            cellTitle = channel.name
        }
        
        let cell = TableViewCell(style: .subtitle, reuseIdentifier: "ok")
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.onyx
        cell.textLabel?.text = cellTitle
        cell.textLabel?.textColor = UIColor.white
        if selectedIndex == indexPath.row{
            cell.textLabel?.textColor = UIColor.mountainMistGray
        }
        cell.detailTextLabel?.textColor = UIColor.fireEngineRed
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.selectionStyle = .none
        cell.pulseAnimation = .none
        
        cell.tintColor = .white
        return cell
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
       // DDLogVerbose("didSelectRowAt")


    }

    

    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return DebugView.emptyView(section: section)
    }
}
