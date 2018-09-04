//
//  TextFieldDesignExt.swift
//  HopeathonAdmin
//
//  Created by Resky Javieri on 04/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TextFieldDesignExt: UITextField {
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red: 153/255, green: 243/255, blue: 251/255, alpha: 100).cgColor
        self.layer.cornerRadius = 15
        
        if let image = leftImage {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 25, height: 25))
            imageView.image = image
            imageView.tintColor = tintColor
            
            var width = leftPadding + 23
            
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width = width + 7
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 25))
            view.addSubview(imageView)
            
            leftView = view
            
        } else {
            leftViewMode = .never
        }
        
        
    }
}
