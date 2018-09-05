//
//  RekamMedisViewController.swift
//  HopeathonAdmin
//
//  Created by Jason Elian on 05/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RekamMedisViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    let idRekamMedis : String = "rekamMedisID"
    
    var userID : String?
    
    var listRekamMedis : [RekamMedisModel] = [RekamMedisModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "RekamMedisTableViewCell", bundle: nil), forCellReuseIdentifier: idRekamMedis)
        
        guard let unwrappedUserId = userID else {return}
        
        readDatabase(userID: unwrappedUserId)
    }
    
    fileprivate func readDatabase(userID : String) {
        
        let ref : DatabaseReference = Database.database().reference()
        
        ref.child("HistoryPatient/\(userID)").observeSingleEvent(of: DataEventType.value) { (snapshot) in
            guard let value = snapshot.value as? [String : Any] else {return}
            
            let tempValue = self.convertToDictionary(value: value)
            print("hello = \(tempValue)")
            
//            var tempNewData : [RekamMedisModel] = [RekamMedisModel]()
            
            for user in tempValue {
                print("user = \(user)")
                
                guard let newUser = user.value as? [String : Any] else {return}
                print("newUser = \(newUser)")
//                tempNewData.append(("\(newUser["beratBadan"]!)", "\(newUser["timestamp"]!)", "\(newUser["tinggi"]!)"))
                
                let stringDate = "\(newUser["timestamp"]!)"
                
//                let date = Date().setDifferenceDate(timestampPast: Int(stringDate)!).split(separator: " ")[0]
                let newRekamMedis = RekamMedisModel(tinggi: Float("\(newUser["tinggi"]!)"), berat: Float("\(newUser["beratBadan"]!)"), date: stringDate)
                self.listRekamMedis.append(newRekamMedis)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("reloaded")
            }
        }
        
    }
    
    func convertToDictionary(value : [String : Any]) -> [String : Any] {
        guard let values = value as? [String : Any] else {return [String : Any]()}
        print("ini values = \(values)")
        return values
    }

}

extension RekamMedisViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listRekamMedis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idRekamMedis, for: indexPath) as! RekamMedisTableViewCell
        
        cell.labelTinggi.text = "\(listRekamMedis[indexPath.row].tinggi!) cm"
        cell.labelBerat.text = "\(listRekamMedis[indexPath.row].berat!) kg"
        let newDate = "\(Date().convertToDate(date: "\(listRekamMedis[indexPath.row].date!)"))".split(separator: "+")[0]
        cell.labelDate.text = "\(newDate)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
}
