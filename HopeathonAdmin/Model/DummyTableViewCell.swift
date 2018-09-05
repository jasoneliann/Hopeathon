//
//  DummyTableViewCell.swift
//  HopeathonAdmin
//
//  Created by Jason Elian on 05/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import UIKit

class DummyTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewDummy : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
