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
        self.backgroundColor = UIColor.init(red: 45/255, green: 122/255, blue: 143/255, alpha: 1)
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func designButtonTwo(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.black, for: .normal)
        
    }
}
