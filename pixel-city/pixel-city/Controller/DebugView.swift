import Foundation
import UIKit

// for debugging player expanding sections
let 🤡 = true



protocol DismissViewControllerProtocol {
    func dismissVC()
}

// http://stackoverflow.com/questions/24051396/class-conforming-to-protocol-as-function-parameter-in-swift

enum myTableView: CGFloat {
    case sectionTitleHeight = 60
    case tableHeaderHeight = 24
    case filterHeight = 80
    case tableFooterHeight = 69
    case promoBugHeaderHeight = 40
}


class DebugView: NSObject {

    // it seems returning nil in latest uikit  will add extra space.
    // this factory will spit out a uiview that's 1x1 pixels.
    // http://stackoverflow.com/questions/18880341/why-is-there-extra-padding-at-the-top-of-my-uitableview-with-style-uitableviewst

    // N.B. - this can be helpful to see the underlying view at same time
    class func fullScreenOrigin() -> CGPoint {
       return CGPoint(x: 0, y: 0)
    }
    
    // Why not return nil? - see link above
    class func emptyView() -> UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0.1, height: 0.1))
    }

    class func emptyExpandingSectionView(section: Int) -> UIView {
        if 🤡 == true {
            let rect = CGRect(x: 0, y: 0, width: 300, height: 24)
            let view = UIView(frame: rect)
            view.backgroundColor = .yellow
            let label = UILabel(frame: rect)
            label.text = "   > 🤡  Empty Expanding section:\(section)"
            label.font = UIFont.boldSystemFont(ofSize: 11)
            label.textColor = .black
            view.addSubview(label)
            return view
        } else {
            return emptyView()
        }
    }

    class func emptyView(section: Int) -> UIView {
        if 🤡 == true {
            let rect = CGRect(x: 0, y: 0, width: 300, height: 24)
            let view = UIView(frame: rect)
            view.backgroundColor = .orange
            let label = UILabel(frame: rect)
            label.text = " 👹  Empty Section:\(section)"
            label.font = UIFont.boldSystemFont(ofSize: 11)
            label.textColor = .white
            view.addSubview(label)
            return view
        } else {
            return emptyView()
        }
    }

    class func emptyTableHeaderView() -> UIView {
        if 🤡 == true {
            let rect = CGRect(x: 0, y: 0, width: screenWidth, height: myTableView.tableHeaderHeight.rawValue)
            let view = UIView(frame: rect)
            view.backgroundColor = .red
            let label = UILabel(frame: rect)
            label.text = " 💀  Empty TableHeaderView"
            label.font = UIFont.boldSystemFont(ofSize: 13)
            label.textColor = .white
            view.addSubview(label)
            return view
        } else {
            return emptyView()
        }
    }

    class func emptyExpandingTableHeaderView() -> UIView {
        if 🤡 == true {
            let rect = CGRect(x: 0, y: 0, width: 300, height: myTableView.tableHeaderHeight.rawValue)
            let view = UIView(frame: rect)
            view.backgroundColor = .red
            let label = UILabel(frame: rect)
            label.text = "> 👻  Expanding TableHeaderView/FooterView"
            label.font = UIFont.boldSystemFont(ofSize: 11)
            label.textColor = .white
            view.addSubview(label)
            return view
        } else {
            return emptyView()
        }
    }

    // why 0.01? https://stackoverflow.com/questions/15389190/set-height-to-0-for-header-view-of-uitableview
    class func zeroHeight() -> CGFloat {
        if 🤡 == true {
            return 24
        } else {
            return 0.01
        }
    }

    class func generateRandomColor() -> UIColor {
        let hue: CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation: CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness: CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black

        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

   
}
