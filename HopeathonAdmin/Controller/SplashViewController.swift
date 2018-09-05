//
//  SplashViewController.swift
//  HopeathonAdmin
//
//  Created by Jason Elian on 05/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import Foundation
import UIKit
class SplashViewController : UIViewController {
    
    let stringasd : String = "segueToLogin"
    
    @IBOutlet weak var imageViewSplash: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.imageViewSplash.alpha = 0
        }) { (_) in
            self.performSegue(withIdentifier: self.stringasd, sender: nil)
        }
        
    }
}
