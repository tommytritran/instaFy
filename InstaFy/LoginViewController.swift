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
    
    func alertMsg(msg:String, errorTitle:String){
        let alertController = UIAlertController(title: errorTitle + " Error", message: msg, preferredStyle: .alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        // create a cancel action
        
        
        self.present(alertController, animated: true,completion: nil)
        
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        if(username.isEmpty || password.isEmpty){
            if(username.isEmpty && password.isEmpty){
                self.alertMsg(msg: "Please type in username and password", errorTitle: "Input")
            }else if(username.isEmpty){
                self.alertMsg(msg: "Please type a username", errorTitle: "Input")
            }else{
                self.alertMsg(msg: "Please type a password", errorTitle: "Input")
            }
        }else{
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                    self.alertMsg(msg: error.localizedDescription, errorTitle: "User log in failed")
                } else {
                    print("User logged in successfully")
                    // display view controller that needs to shown after successful login
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    
                }
            }
        }
    }
    @IBAction func onSignUp(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        if(username.isEmpty || password.isEmpty){
            if(username.isEmpty && password.isEmpty){
                self.alertMsg(msg: "Please type in username and password", errorTitle: "Input")
            }else if(username.isEmpty){
                self.alertMsg(msg: "Please type a username", errorTitle: "Input")
            }else{
                self.alertMsg(msg: "Please type a password", errorTitle: "Input")
            }
        }else{
            // initialize a user object
            let newUser = PFUser()
            
            // set user properties
            newUser.username = username
            newUser.password = password
            
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                    self.alertMsg(msg: "could not access server", errorTitle: "Connection")
                } else {
                    print("User Registered successfully")
                    // manually segue to logged in view
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    //self.presentView(ChatViewController, animated: true, completion: nil)
                    
                    
                }
            }
        }
    }
    

 }
