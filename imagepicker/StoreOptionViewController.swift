//
//  StoreOptionViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/18/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import UIKit

class StoreOptionViewController: UIViewController {
    var image: UIImage?
    var searchKey: String = ""
    
    @IBOutlet weak var YelpButton: UIButton!
    @IBOutlet weak var WalmartButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        changeShape(button: YelpButton)
        changeShape(button: WalmartButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func changeShape(button: UIButton) {
      
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
    }
    
    @IBAction func YelpButtonTapped(_ sender: UIButton) {
        UIView.transition(with: YelpButton, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: { _ in
            self.performSegue(withIdentifier: "Yelp", sender: self)

        })
    }
    
    @IBAction func WalmartButtonTapped(_ sender: UIButton) {
        UIView.transition(with: WalmartButton, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: { _ in
            self.performSegue(withIdentifier: "Walmart", sender: self)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Yelp" {
            let destination = segue.destination as? BusinessViewController
            destination?.searchKey = searchKey
        } else if segue.identifier == "Walmart" {
            let destination = segue.destination as? WalmartViewController
            destination?.searchKey = searchKey
        }
    }
}
