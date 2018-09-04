//
//  DetailPasienViewController.swift
//  HopeathonAdmin
//
//  Created by Rhesa Febrin Saputra on 9/4/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import UIKit

class DetailPasienViewController: UIViewController {

    @IBOutlet weak var fotoPasien: UIImageView!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var golonganDarah: UILabel!
    @IBOutlet weak var usiaLabel: UILabel!
    @IBOutlet weak var tinggiLabel: UILabel!
    @IBOutlet weak var beratLabel: UILabel!
    
    @IBOutlet weak var riwayatPenyakit: UIButton!
    
    @IBOutlet weak var imunisasi: UIButton!
    
    @IBOutlet weak var medicalRecord: UIButton!
    
    var userModel : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let user = userModel else {return}
        golonganDarah.text = "O"
        //            usiaLabel.text = Date().convertToDate(date: user.dateBirth)
        usiaLabel.text = "\(Date().convertToDate(date: user.dateBirth))"
        tinggiLabel.text = "\(user.tinggiBadan) cm"
        beratLabel.text = "\(user.beratBadan) kg"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
