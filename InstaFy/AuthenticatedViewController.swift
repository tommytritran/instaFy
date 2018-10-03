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
    
    @IBAction func goToCompose(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ComposeViewController") as! ComposeViewController
        
        self.navigationController!.pushViewController(secondViewController, animated: true)
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
                        let caption = post["caption"] as? String
                        cell.photoView.image = image
                        if caption != nil {
                            cell.captionLabel.text = caption
                        }
                    }
                }
            })
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender:Any?) {
        if(sender != nil) {
            
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.post = post
                
                let postCell = sender as! ImageCell
                detailViewController.image = postCell.photoView.image!
            }
        }
    }
    func getImages(){
        let query = Post.query()
        query?.order(byAscending: "createdAt")
        query?.includeKey("author")
        query?.includeKey("timestamp")
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
