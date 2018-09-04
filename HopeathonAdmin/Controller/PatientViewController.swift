//
//  PatientViewController.swift
//  HopeathonAdmin
//
//  Created by Jason Elian on 04/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class PatientViewController: UIViewController {
    
    let idCellProfile : String = "PatientTableViewCell"
    
    @IBOutlet weak var tableView : UITableView!
    
    var listUser : [UserModel] = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PatientTableViewCell", bundle: nil), forCellReuseIdentifier: idCellProfile)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        listUser = [UserModel]()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        readDatabase()
    }
    
    fileprivate func readDatabase() {
        
        guard let userID = Auth.auth().currentUser?.uid else {return}
//        let userID : String = "XuprP0q1cXZJ0YBKTRb1DVaRGWD3"
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
                    print("ini newUser = \(newUser)")
                    self.listUser.append(newUser)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print("reloaded")
                }
            })
            
        }

    }
    
    func convertToDictionary(value : [String : Any]) -> [String : Any] {
        guard let values = value as? [String : Any] else {return [String : Any]()}
        print("ini values = \(values)")
        return values
    }
    
}

extension PatientViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUser.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCellProfile, for: indexPath) as! PatientTableViewCell
        cell.labelName.text = listUser[indexPath.row].fullName
//        cell.labelAge.text = Date().getDateNow(unixtimeInterval: listUser[indexPath.row].dateBirth)
        cell.labelAge.text = Date().setDifferenceDate(timestampPast: Int(listUser[indexPath.row].dateBirth)!)
        cell.labelGender.text = (listUser[indexPath.row].gender == "L" ? "Laki-Laki" : "Perempuan")
        cell.backgroundColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("asd")
        performSegue(withIdentifier: "toDetailPatient", sender: listUser[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailPatient" {
            let dest = segue.destination as! DetailPasienViewController
            dest.userModel = sender as! UserModel
            print("hello")
        }
        
    }
    
}

extension Date {
    
    func getDateNow(unixtimeInterval : String) -> String {
//        guard let doubleUnix = unixtimeInterval as? Double else {return ""}
        let date = Date(timeIntervalSince1970: TimeInterval.init(unixtimeInterval)!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        return dateFormatter.string(from: date)
    }
}
