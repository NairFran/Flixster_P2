//
//  Detail2ViewController.swift
//  lab-tunley
//
//  Created by Walter Franchino on 2/12/23.
//

import UIKit

class Detail2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        if let tappedView = sender.view {
            performSegue(withIdentifier: "moreSegue", sender: tappedView)
        }
    }
}
