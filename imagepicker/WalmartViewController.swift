//
//  WalmartViewController.swift
//  imagepicker
//
//  Created by Zhaoya Sun on 7/18/17.
//  Copyright © 2017 Sara Robinson. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class WalmartViewController: UIViewController {
    
    
    @IBOutlet weak var itemTableView: UITableView!
    var items = WalmartApiHelper.items
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            let cell = sender as! ItemCell
            let vc = segue.destination as! DetailViewController
            let indexPath = itemTableView.indexPath(for: cell)
            if let indexPath = indexPath {
                vc.item = items[indexPath.row]
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension WalmartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemTableView.deselectRow(at: indexPath, animated: true)
    }

}

extension WalmartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //   print(businesses.count)
        print(items.count)
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let itemInfo = items[indexPath.row]
        
        cell.viewModel = ItemCellViewModel(withItem: itemInfo)
        
        return cell
    }
    
    
    
}



