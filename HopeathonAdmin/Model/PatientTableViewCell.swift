//
//  PatientTableViewCell.swift
//  HopeathonAdmin
//
//  Created by Jason Elian on 04/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import UIKit

class PatientTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewPatient: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelGender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageViewPatient.layer.cornerRadius = imageViewPatient.bounds.width / 2
        imageViewPatient.backgroundColor = .blue
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
