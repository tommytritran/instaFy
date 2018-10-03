//
//  ComposeViewController.swift
//  InstaFy
//
//  Created by Tommy Tran on 01/10/2018.
//  Copyright © 2018 Tommy Tran. All rights reserved.
//

import UIKit
import Parse

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectedImageIV: UIImageView!
    
    @IBOutlet weak var captionLabel: UITextField!
    let vc = UIImagePickerController()
    var tmpImg = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        vc.delegate = self
        optionMsg()

    }
    func optionMsg(){
        let alertController = UIAlertController(title: "Choose option", message: "Choose option", preferredStyle: .alert)
        
        // create an OK action
        let cameraOption = UIAlertAction(title: "Camera", style: .default) { (action) in
            // handle response here.
            self.showErrorMsg()
        }
        // add the OK action to the alert controller
        alertController.addAction(cameraOption)
        // create a photolibrary action
        let photolibraryOption = UIAlertAction(title:"Photolibrary", style: .default){(action) in
            self.showPhotoLibrary()
        }
        alertController.addAction(photolibraryOption)
        
        let cancelOption = UIAlertAction(title: "Cancel", style: .default){
            (action) in alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction( cancelOption)
        self.present(alertController, animated: true, completion: nil)
        
    }
    func showPhotoLibrary(){
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
  
    
    func showErrorMsg(){
        let alertController = UIAlertController(title: "Option not available", message: "This feature is currently not available", preferredStyle: .alert)
        let cancelOption = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        alertController.addAction(cancelOption)
        self.present(alertController, animated: true, completion: nil)
    }
    
   @objc func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image captured by the UIImagePickerController
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
       // let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        selectedImageIV.image = selectedImage
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func shareImage(_ sender: Any) {
        print("Hello")
        if selectedImageIV != nil && captionLabel.text != nil{
            Post.postUserImage(image: selectedImageIV.image, withCaption: captionLabel.text) { (bool, error) in
                if let error = error{
                    print(error.localizedDescription)
                } else {
                    print("Sent")
                    self.performSegue(withIdentifier: "goBackSegue", sender: nil)
                }
                
            }
      }
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        self.optionMsg()
        
    }

}
