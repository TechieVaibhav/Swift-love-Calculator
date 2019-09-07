//
//  MainViewController.swift
//  Calculator
//
//  Created by Vaibhav Sharma on 22/06/19.
//  Copyright © 2019 Vaibhav Sharma. All rights reserved.
//

import UIKit
import HeartLoadingView

class MainViewController: UIViewController {
    
    @IBOutlet weak var heartView: HeartLoadingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let doubleValue = Double(100)
        let value: Double = doubleValue/100
        heartView.layoutIfNeeded()
        heartView.isShowProgressText = false
        heartView.progress = Double(value)
        heartView.heavyHeartColor = UIColor(red: 255.0/255.0, green:  255.0/255.0, blue:  255.0/255.0, alpha: 1)
        heartView.lightHeartColor = UIColor(red: 255.0/255.0, green:  255.0/255.0, blue:  255.0/255.0, alpha: 0.5)
        heartView.fillHeartColor = UIColor.white.withAlphaComponent(0.7)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
