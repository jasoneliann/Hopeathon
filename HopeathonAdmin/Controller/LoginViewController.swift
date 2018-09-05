//
//  LoginViewController.swift
//  HopeathonAdmin
//
//  Created by Jason Elian on 04/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var loggedInButton: UIButton!
    
    //MARK : - Properties
    let segueToLandingPage : String = "toLandingPage"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logInButton.designButtonOne()
        self.loggedInButton.designButtonOne()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        logInButton.addTarget(self, action: #selector(loginWithGoogle), for: .touchUpInside)
        
//        GIDSignIn.sharedInstance().signInSilently()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func loginWithGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
    
}

extension LoginViewController : GIDSignInUIDelegate {
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print("masuk sini")
        return true
    }
    
}


extension LoginViewController : GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("hello")
        //        guard let err = error else {return}
        
        if let error = error {
            print("error")
            return
        }
        
        
        guard let authentication = user.authentication else {return}
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
            // User is signed in
            print("signed in")
            
            let ref : DatabaseReference = Database.database().reference()
            guard let uid = authResult?.user.uid, let email = authResult?.user.email, let fullName = authResult?.user.displayName else {return}
            
            let dict = [
                "uid" : uid,
                "email" : email,
                "dateBirth" : "1536054273",
                "gender" : "L",
                "fullName" : fullName
            ]
            
            ref.child("user/\(uid)").setValue(dict)
            
            UserDefaults.standard.setValue("\(uid)", forKey: "uid")
            
            print("masuk")
            self.performSegue(withIdentifier: self.segueToLandingPage, sender: self)
            print("segue")
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    
}
