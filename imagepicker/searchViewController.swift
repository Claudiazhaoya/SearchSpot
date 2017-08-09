//
//  searchViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 8/2/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import Foundation
import UIKit

class searchViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchInStores" {
            let destination = segue.destination as? StoreOptionViewController
            destination?.searchKey = textField.text!.removingWhitespaces()
        }
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "searchInStores", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
