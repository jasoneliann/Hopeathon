//
//  RekamMedisTableViewCell.swift
//  HopeathonAdmin
//
//  Created by Jason Elian on 05/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import UIKit

class RekamMedisTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelDate : UILabel!
    @IBOutlet weak var labelTinggi : UILabel!
    @IBOutlet weak var labelBerat : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
