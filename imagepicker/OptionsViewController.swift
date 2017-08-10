//
//  OptionsViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/12/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class OptionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var loadImageButton: UIButton!
    @IBOutlet weak var voiceButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var selectedImage:UIImage?
    //select the image source from camera
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        UIView.transition(with: cameraButton, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: { _ in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .camera
        })
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    //select the image source from album
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        UIView.transition(with: loadImageButton, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: { _ in
            sender.isUserInteractionEnabled = false
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            sender.isUserInteractionEnabled = true
        })
        present(imagePicker, animated:  true, completion:  nil)
    }
    
    @IBAction func speechToTextButtonTapped(_ sender: UIButton) {
        UIView.transition(with: voiceButton, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: { _ in
            self.performSegue(withIdentifier: "speechToText", sender: self)
        })
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        UIView.transition(with: searchButton, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: { _ in
            self.performSegue(withIdentifier: "search", sender: self)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "option" {
            let destination = segue.destination as? StoreOptionViewController
            destination?.image = selectedImage
        }
    }
    
    
    func changeShape(button: UIButton) {
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        changeShape(button: cameraButton)
        changeShape(button: loadImageButton)
        changeShape(button: voiceButton)
        changeShape(button: searchButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //get the image from either source type
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        spinner.startAnimating()
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.selectedImage = pickedImage
            if picker.sourceType == .camera {
                UIImageWriteToSavedPhotosAlbum(self.selectedImage!, nil, nil, nil);
            }
            let binaryImageData = ImagePickerHelper.base64EncodeImage(selectedImage!)
            ImagePickerHelper.createRequest(with: binaryImageData, completion: { (detectedItem) in
                self.spinner.stopAnimating()
                self.performSegue(withIdentifier: "option", sender: self)
            })
        }
        dismiss(animated: true, completion: nil)
    }
    //deal with the cancel situation
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
