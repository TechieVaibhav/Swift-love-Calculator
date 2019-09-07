//
//  ViewController.swift
//  Calculator
//
//  Created by Vaibhav Sharma on 18/06/19.
//  Copyright © 2019 Vaibhav Sharma. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldFirstName: TextField!
    @IBOutlet weak var textFieldSecondName: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textFieldFirstName.layer.cornerRadius = textFieldFirstName.frame.size.height/2
        textFieldFirstName.layer.borderWidth = 1.0
        textFieldFirstName.layer.borderColor = UIColor.white.cgColor
        textFieldSecondName.layer.cornerRadius = textFieldSecondName.frame.size.height/2
        textFieldSecondName.layer.borderWidth = 1.0
        textFieldSecondName.layer.borderColor = UIColor.white.cgColor
        textFieldFirstName.delegate = self
    }
    func calculateLovePercentage(fName: String, secName: String) {
        print("fName : \(fName).....secName : \(secName)")
        alamofireRequestApi(yourName: fName, loveName: secName)
    }
    
    @IBAction func buttonPresed(_ sender: Any) {
        guard let firstName = self.textFieldFirstName.text,  !firstName.isEmpty else {
            self.showAlert(mesg: "Please enter your name first.")
            return
        }
        guard let secName = self.textFieldSecondName.text,  !secName.isEmpty else {
            self.showAlert(mesg: "Please enter your partner name.")
            return
        }
        calculateLovePercentage(fName: firstName.capitalized, secName: secName.capitalized)
    }
    
    func alamofireRequestApi(yourName : String, loveName : String) {
        guard let url = URL(string: "https://love-calculator.p.rapidapi.com/getPercentage") else {
            return
        }
        showHud()
        let params = ["fname" : "\(yourName)", "sname":"\(loveName)"]
        let headers : HTTPHeaders = [ "X-RapidAPI-Host":"love-calculator.p.rapidapi.com","X-RapidAPI-Key" : "f5261d0b21mshe23ba882364feadp12f080jsn3ab48e3e49fc" ]
        Alamofire.request(url,method: .get ,parameters : params,encoding: URLEncoding.default ,headers:headers).responseJSON {response in
            print(response)
            self.parseResponse(data: response.data)
            self.hideHud()
        }
    }
    func parseResponse(data: Data?)  {
        //clear
        self.textFieldFirstName.text = ""
        self.textFieldSecondName.text = ""
        let dataDict: [String: String]? = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: String]
        if let dataDict = dataDict {
            if let per = dataDict["percentage"] {
                self.performSegue(withIdentifier: "resultVC", sender: per)
            } else {
                self.showAlert(mesg: "Please Try After Some Time.")
            }
        }
    }
    
    func showHud()  {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    func  hideHud() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultController = segue.destination as? ResultViewController {
            resultController.percetageString = sender as? String
        }
    }
    func showAlert(mesg: String) {
        let alert = UIAlertController(title: "", message: mesg,         preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)//UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return  bounds.inset(by: padding)
    }
}

extension ViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isNumeric{
            return false
        }
        return true
    }
}
extension String {
    var isNumeric : Bool {
        return NumberFormatter().number(from: self) != nil
    }
}
