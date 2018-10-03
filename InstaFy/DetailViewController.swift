//
//  DetailViewController.swift
//  InstaFy
//
//  Created by Tommy Tran on 02/10/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit
import Parse
class DetailViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var detailImageview: UIImageView!
    var post: PFObject!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailImageview.image = image
        self.usernameLabel.text = post["author"] as? String
        self.captionLabel.text = post["caption"] as? String
        self.timestampLabel.text = post["timestamp"] as? String

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
