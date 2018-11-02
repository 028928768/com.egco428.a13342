//
//  CookiesViewController.swift
//  com.egco428.a13342
//
//  Created by Kanta'MacPro on 31/10/2561 BE.
//  Copyright © 2561 Kanta'MacPro. All rights reserved.
//

import UIKit
import os.log

class CookiesViewController: UIViewController {
    var newCookie: Result?
    let closed_Cookie = UIImage(named: "Close-CookieIMG")
    let opened_Cookie = UIImage(named: "Open-CookieIMG")
    //MARK: Properties
    
    @IBOutlet weak var resultSQL: UILabel!
    @IBOutlet weak var cookieImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var newCookieDate: UILabel!
   
    
    //date picker
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cookieImage.image = closed_Cookie
        saveButton.isHidden = true
        
        
    }
    
    //Shake Handler Actions
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
            
            // Date Picker
            let dateTest = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm a"
            dateFormatter.locale = Locale(identifier: "th")
            
            self.showToast(message: "Waiting")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                // Put your code which should be executed with a delay here
                self.cookieImage.image = self.opened_Cookie
                self.resultSQL.text = "New Propercy!!"
                self.newCookieDate.text = dateFormatter.string(from: dateTest)
                self.saveButton.isHidden = false
            })
//            cookieImage.image = opened_Cookie
//            resultSQL.text = "New Propercy!!"
//            newCookieDate.text = dateFormatter.string(from: dateTest)
//            saveButton.isHidden = false
        }
    }
    
    //Toast function
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
   
    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIButton, button === saveButton else {
            os_log("The save button was not pressed, cancelling",log: OSLog.default,type: .debug)
            return
        }
        
        let newCookie_Result = resultSQL.text ?? ""
        let newCookie_Photo =  UIImage(named:"Open-CookieIMG")
        let newCookie_DateTime = newCookieDate.text ?? ""
       
        
       // let testPhoto = UIImage(named:"Open-CookieIMG") newCookie_Result
        
        newCookie = Result(cookiePhoto: newCookie_Photo, result: newCookie_Result, datetime: newCookie_DateTime, type: "Positive")
        
    }
    
  
    

}
