//
//  ResultViewController.swift
//  Calculator
//
//  Created by Vaibhav Sharma on 20/06/19.
//  Copyright © 2019 Vaibhav Sharma. All rights reserved.
//

import UIKit
import HeartLoadingView
class ResultViewController: UIViewController {
    
    @IBOutlet weak var loadingView: HeartLoadingView!
    @IBOutlet weak var percentageLbl: UILabel!
    var percetageString : String?
    var fName: String?
    var secName: String?
    
    @IBOutlet weak var lblBetween: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let doubleValue = Double(percetageString ?? "0") ?? 0
        let value: Double = doubleValue/100
        print(value)
        loadingView.layoutIfNeeded()
        loadingView.isShowProgressText = false
        loadingView.progress = Double(value)
        loadingView.heavyHeartColor = UIColor(red: 255.0/255.0, green:  255.0/255.0, blue:  255.0/255.0, alpha: 1)
        loadingView.lightHeartColor = UIColor(red: 255.0/255.0, green:  255.0/255.0, blue:  255.0/255.0, alpha: 0.5)
        loadingView.fillHeartColor = UIColor.white.withAlphaComponent(0.7)
        percentageLbl.text = [(percetageString ?? "0"), "%"].joined(separator: "")
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        self.takeScreenShot()
    }
    func takeScreenShot() {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        shareScreenShot(image: image)
    }
    func shareScreenShot(image : UIImage)  {
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(vc, animated: true)
    }
}
