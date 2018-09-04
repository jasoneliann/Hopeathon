//
//  DetailPasienViewController.swift
//  HopeathonAdmin
//
//  Created by Rhesa Febrin Saputra on 9/4/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DetailPasienViewController: UIViewController {

    @IBOutlet weak var fotoPasien: UIImageView!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var golonganDarah: UILabel!
    @IBOutlet weak var usiaLabel: UILabel!
    @IBOutlet weak var tinggiLabel: UILabel!
    @IBOutlet weak var beratLabel: UILabel!
    
    @IBOutlet weak var labelUsername: UILabel!
    
    @IBOutlet weak var imunisasiView: UIImageView!
    
    @IBOutlet weak var riwayatPenyakitView: UIImageView!
    @IBOutlet weak var medicalRecord: UIButton!
    
    
    var userModel : UserModel?
    
    var imageProfile : UIImage?
    
    var userId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imunisasiView.layer.cornerRadius = 15
    
       self.imunisasiView.clipsToBounds = true
        self.riwayatPenyakitView.layer.cornerRadius = 15
        
        self.riwayatPenyakitView.clipsToBounds = true
//        self.riwayatPenyakit.layer.cornerRadius = 15
        
        self.beratLabel.layer.cornerRadius = 8
        self.beratLabel.clipsToBounds = true
        self.tinggiLabel.layer.cornerRadius = 8
        self.tinggiLabel.clipsToBounds = true
        
        self.medicalRecord.designButtonOne()

        // Do any additional setup after loading the view.
        
        if let user = userModel {
            golonganDarah.text = "O"
            labelUsername.text = user.fullName
            //            usiaLabel.text = Date().convertToDate(date: user.dateBirth)
            let asd = "\(Date().convertToDate(date: user.dateBirth))".split(separator: " ")[0]
            usiaLabel.text = String(asd)
            tinggiLabel.text = "\(user.tinggiBadan) cm"
            beratLabel.text = "\(user.beratBadan) kg"
            
            
            if user.gender == "L" {
                genderImage.image = UIImage(named: "Male")
            }
            
            guard let image = imageProfile else {return}
            fotoPasien.image = image
        }
        
        guard let unwrappedUserId = userId else {return}
        
        readDatabase(userID: unwrappedUserId)
//        guard let user = userModel else {return}
        
        
    }
    
    fileprivate func readDatabase(userID : String) {
        
        print("userId = \(userID)")
        let ref : DatabaseReference = Database.database().reference()
        
        ref.child("HistoryPatient/\(userID)").observeSingleEvent(of: DataEventType.value) { (snapshot) in
            guard let value = snapshot.value as? [String : Any] else {return}
            
            let tempValue = self.convertToDictionary(value: value)
            print("hello = \(tempValue)")
            
            var tempNewData : [(String, String, String)] = [(String, String, String)]()
            
            for user in tempValue {
                print("user = \(user)")
                
                guard let newUser = user.value as? [String : Any] else {return}
                print("newUser = \(newUser)")
                tempNewData.append(("\(newUser["beratBadan"]!)", "\(newUser["timestamp"]!)", "\(newUser["tinggi"]!)"))
                print("tampUser = \(tempNewData)")
            }
            
            ref.child("user/\(userID)").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                guard let value0 = snapshot.value as? [String : Any] else {return}
                let tempValue0 = self.convertToDictionary(value: value0)
                
                for newData in tempNewData {
                    
                    let newUser = UserModel(timestamp: newData.1, id: "\(tempValue0["uid"]!)", email: "\(tempValue0["email"]!)", fullName: "\(tempValue0["fullName"]!)", dateBirth: "\(tempValue0["dateBirth"]!)", gender: "\(tempValue0["gender"]!)", beratBadan: Float(newData.0)!, tinggiBadan: Float(newData.2)!)
                    print("ini newUserasdasdsd = \(newUser)")
                    self.userModel = newUser
                    
                    self.labelUsername.text = "\(newUser.fullName)"
                    self.beratLabel.text = "\(newUser.beratBadan)"
                    print("berat = \(self.beratLabel.text!)")
                    self.tinggiLabel.text = "\(newUser.tinggiBadan)"
                    
                    if newUser.gender == "L" {
                        self.genderImage.image = UIImage(named: "Male")
                    }
                    
                    self.golonganDarah.text = "O"
                    
                    let asd = "\(Date().convertToDate(date: newUser.dateBirth))".split(separator: " ")[0]
                    
                    self.usiaLabel.text = String(asd)
                }
                
//                DispatchQueue.main.async {
////                    self.tableView.reloadData()
//                    print("reloaded")
//                }
            })
        }
    }
    
    func convertToDictionary(value : [String : Any]) -> [String : Any] {
        guard let values = value as? [String : Any] else {return [String : Any]()}
        print("ini values = \(values)")
        return values
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
