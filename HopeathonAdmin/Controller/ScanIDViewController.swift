//
//  ScanIDViewController.swift
//  HopeathonAdmin
//
//  Created by Rhesa Febrin Saputra on 9/4/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import UIKit

class ScanIDViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var inputIDPasien: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func prosesAction(_ sender: Any) {
        if inputIDPasien.text == "19014"
        {
            performSegue(withIdentifier: "prosesID", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "ID Pasien Salah", message: "Pastikan Nomor ID yang Dimasukkan Sudah Benar", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ulangi", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
