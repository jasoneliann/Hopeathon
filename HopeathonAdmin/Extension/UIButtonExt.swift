//
//  UIButtonExt.swift
//  HopeathonAdmin
//
//  Created by Resky Javieri on 04/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func designButtonOne(){
        self.backgroundColor = UIColor.init(red: 153/255, green: 243/255, blue: 251/255, alpha: 100)
        self.layer.cornerRadius = 15
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func designButtonTwo(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 15
        self.setTitleColor(UIColor.black, for: .normal)
        
    }
}
