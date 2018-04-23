//
//  PopVC.swift
//  pixel-city
//
//  Created by David Brunstein on 2018-04-23.
//  Copyright © 2018 David Brunstein. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {

    // Outlets
    @IBOutlet weak var popImageView: UIImageView!
    
    // Variables
    var passedImage: UIImage!
    
    func initData(forImage image: UIImage) {
        self.passedImage = image
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        popImageView.image = passedImage
        addDoubleTap()
    }

    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dismissPhoto))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func dismissPhoto() {
        dismiss(animated: true, completion: nil)
    }
}
