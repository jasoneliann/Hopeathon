//
//  ProfileViewController.swift
//  HopeathonAdmin
//
//  Created by Resky Javieri on 04/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var isCurrentlyEditing: Bool = false
    @IBOutlet weak var detailDraftNavBar: UINavigationItem!
    
    @IBOutlet weak var posyanduTextField: TextFieldExt!
    @IBOutlet weak var idKaderTextField: TextFieldExt!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addedProfileImage: UIButton!
    
    @IBOutlet weak var labelFullName: UILabel!
    
    @IBAction func addedProfileButton(_ sender: Any) {
        
        let profilePicture = UIImagePickerController()
        profilePicture.delegate = self
        profilePicture.sourceType = UIImagePickerControllerSourceType.photoLibrary
        profilePicture.allowsEditing = false
        
        self.present(profilePicture, animated: true) {
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let profilePicture = info[UIImagePickerControllerOriginalImage] as? UIImage   {
            profileImageView.image = profilePicture
        } else {
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        self.changeEditState()
    }
    
    func changeEditState() {
        
        if (self.isCurrentlyEditing == false) {
            self.isCurrentlyEditing = true
            self.detailDraftNavBar.rightBarButtonItem?.title = "Simpan"
            posyanduTextField.isEnabled = true
            idKaderTextField.isEnabled = true
        } else {
            self.isCurrentlyEditing = false
            self.detailDraftNavBar.rightBarButtonItem?.title = "Ubah"
            posyanduTextField.isEnabled = false
            idKaderTextField.isEnabled = false
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true

        
        self.profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        self.profileImageView.clipsToBounds = true
        self.addedProfileImage.layer.cornerRadius = addedProfileImage.frame.size.width / 2

    }

   

}
