 //
//  LoginViewController.swift
//  InstaFy
//
//  Created by Tommy Tran on 26/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit
 import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        } 
    }
    @IBAction func onSignUp(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil) 
            }
        }
    }
    

 }
