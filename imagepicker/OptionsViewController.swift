//
//  OptionsViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/12/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class OptionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var loadImageButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    var selectedImage:UIImage?

    //select the image source from camera
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }

    //select the image source from album
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated:  true, completion:  nil)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        print("Not working now!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
               
        if segue.identifier == "option" {
            let destination = segue.destination as? StoreOptionViewController
            destination?.image = selectedImage
 //            print("Hello, option!")
 //       } else if segue.identifier == "search" {
 //           let destination = segue.destination as? BusinessViewController
//            print("Hello, search!")
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "purdue.png")!)
        self.view.contentMode = UIViewContentMode.scaleAspectFill
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //get the image from either source type
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = pickedImage
            self.selectedImage = pickedImage
            
            let binaryImageData = ImagePickerHelper.base64EncodeImage(selectedImage!)
            ImagePickerHelper.createRequest(with: binaryImageData, completion: { (detectedItem) in
                
            
//            let label = ImagePickerHelper.labelResult
            self.performSegue(withIdentifier: "option", sender: self)
        })
        }
        
        dismiss(animated: true, completion: nil)
    }
    //deal with the cancel situation
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
