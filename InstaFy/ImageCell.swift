//
//  ImageCell.swift
//  InstaFy
//
//  Created by Tommy Tran on 28/09/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit
import Parse
import ParseUI
class ImageCell: UITableViewCell {
    
    @IBOutlet weak var photoView: PFImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    var instagramPost: PFObject! {
        didSet {
            self.photoView.file = instagramPost["image"] as? PFFile
            self.photoView.loadInBackground()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
