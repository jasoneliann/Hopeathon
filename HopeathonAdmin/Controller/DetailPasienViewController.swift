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
    
    let segueId : String = "segueToRekamMedis"
    let segueToDummy : String = "toDummy"
    
    @IBAction func doRekamMedis(_ sender: UIButton) {
        performSegue(withIdentifier: segueId, sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.imunisasiView.layer.cornerRadius = 15
    
       self.imunisasiView.clipsToBounds = true
        self.riwayatPenyakitView.layer.cornerRadius = 15
        
        self.riwayatPenyakitView.clipsToBounds = true
//        self.riwayatPenyakit.layer.cornerRadius = 15
        
        self.beratLabel.layer.cornerRadius = 8
        self.beratLabel.clipsToBounds = true
        self.tinggiLabel.layer.cornerRadius = 8
        self.tinggiLabel.clipsToBounds = true
        
        addGestureToImunisasi()
        
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
    
    fileprivate func addGestureToImunisasi() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleTap1))
        self.imunisasiView.isUserInteractionEnabled = true
        self.riwayatPenyakitView.isUserInteractionEnabled = true
        self.imunisasiView.addGestureRecognizer(tapGesture)
        self.riwayatPenyakitView.addGestureRecognizer(tapGesture1)
    }
    
    @objc func handleTap() {
        
        performSegue(withIdentifier: segueToDummy, sender: "SCREEN IMUNISASI")
        
    }
    
    @objc func handleTap1() {
        performSegue(withIdentifier: segueToDummy, sender: "Penyakit")
    }
    
    fileprivate func readDatabase(userID : String) {
        
        print("userId321123 = \(userID)")
        let ref : DatabaseReference = Database.database().reference()
        
        ref.child("HistoryPatient/\(userID)").observeSingleEvent(of: DataEventType.value) { (snapshot) in
            guard let value = snapshot.value as? [String : Any] else {return}
            print("valueee123123123 = \(value)")
            let tempValue = self.convertToDictionary(value: value)
            print("hello = \(tempValue)")
            
            var tempNewData : [(String, String, String)] = [(String, String, String)]()
            
            print("tempValue12345 = \(tempValue)")
            
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
                    print("masuk123123")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueId {
            let dest = segue.destination as! RekamMedisViewController
            
            
            if let unwrappedUserId1 = userId {
                dest.userID = unwrappedUserId1
            } else {
                guard let unwrappedUserId1 = userModel else {return}
                dest.userID = unwrappedUserId1.id
                print("yang ini")
            }
        } else {
            let dest = segue.destination as! DummyTableViewController
            guard let unwrappedSender = sender as? String else {return}
            
            if unwrappedSender.contains("IMUNISASI") {
                dest.titleA = "Imunisasi"
            } else {
                dest.titleA = "Riwayat Penyakit"
            }
            
            dest.dummyImage = UIImage(named: unwrappedSender)
        }
        
        
        
        
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
