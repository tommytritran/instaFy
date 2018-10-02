//
//  AuthenticatedViewController.swift
//  InstaFy
//
//  Created by Tommy Tran on 27/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit
import Parse

class AuthenticatedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getImages()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                print("User logout successfully")
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
        let post = posts[indexPath.row]
        
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground(block: {(data, error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else{
                    DispatchQueue.main.async {
                        let image = UIImage(data: data!)
                        let username = post["author"] as? String
                        let caption = post["caption"] as? String
                        cell.photoView.image = image
                        print(caption)
                        if caption != nil {
                            cell.usernameLabel.text = caption
                        }
                    }
                }
            })
        }
        return cell
    }
    
    func getImages(){
        let query = Post.query()
        query?.order(byAscending: "createdAt")
        query?.includeKey("Author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (Post, error: Error?) -> Void in
            if let posts = Post {
                self.posts = posts as! [Post]
                self.tableView.reloadData()
            } else {
                print("fetch failed")
            }
        }
    }
    
    
    @IBAction func reloadPage(_ sender: Any) {
        self.tableView.reloadData()
    }
    
}
