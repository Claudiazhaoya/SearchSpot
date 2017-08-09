//
//  PopUpViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 8/4/17.
//  Copyright © 2017 Claudia Sun. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    var voiceKey: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        self.showAnimate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToStores" {
            let destination = segue.destination as! StoreOptionViewController
            destination.searchKey = voiceKey
        }
    }
    

    @IBAction func goBackPopUpButtonTapped(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    @IBAction func goToStoreButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToStores", sender: self)
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: { 
            self.view.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.3)
        }, completion: { (finished: Bool) in
            if (finished) {
                self.view.removeFromSuperview()
            }
        })
    }
}
