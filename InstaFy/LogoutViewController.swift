//
//  LogoutViewController.swift
//  InstaFy
//
//  Created by Tommy Tran on 27/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit
import Parse

class LogoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    @IBAction func logout(_ sender: Any) {
        
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                print("User logout successfully")
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            }
        })
    }
}
