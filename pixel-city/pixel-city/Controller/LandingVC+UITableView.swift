import Foundation
import UIKit
import Material
import CocoaLumberjack

extension LandingVC {
  
    // MARK: UITableview datasource / Delegate
    func numberOfSections(in _: UITableView) -> Int {
        return DM.flikrChannels.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: NetworkLandingCell.ID) as? NetworkLandingCell {
            let channel = DM.flikrChannels[indexPath.section]
            cell.configureTableViewCellWithPhotos(channel: channel,photos:channel.photos)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        print("didSelectRowAt")
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return VM.networkCellSize.height
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionTitle = "\(DM.flikrChannels[section].name)"
        let headerSection = HeaderSection(sectionName: "\(sectionTitle)", sectionTitleHeight: 60)
        return headerSection
    }
    
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 60
    }
}
