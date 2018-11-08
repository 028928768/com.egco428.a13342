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
    var cookiesDB = [MessageDB]()
    var messageType: String = ""
    var isShake: Bool = false
    //MARK: Properties
    
    @IBOutlet weak var resultSQL: UILabel!
    @IBOutlet weak var cookieImage: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var newCookieDate: UILabel!
    @IBOutlet weak var cookieMessageResult: UITextView!
    @IBOutlet weak var shakeOutlet: UIImageView!
    //cast image
    let saveButtonImage = UIImage(named: "saveButton")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cookieImage.image = closed_Cookie
        saveButton.isHidden = true
       // storeCookieMessageAndType()
        isShake = false
        
        //animation
      //  saveButton.setImage(saveButtonImage, for: .normal)
        var shakeButtonsList: [UIImage] = []
        for i in 0...4 {
            let fn = "shake-"+String(format: "%d", i)+".png"
            let vImage = UIImage(named: fn)
            shakeButtonsList.append(vImage!)
        }
        shakeOutlet.animationImages = shakeButtonsList
        shakeOutlet.animationDuration = 3
        shakeOutlet.startAnimating()
        
        
        
    }
    
    //Shake Handler Actions
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
            
            if isShake == false {
            // Date Picker
            let dateTest = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm a"
            dateFormatter.locale = Locale(identifier: "th")
            
            self.showToast(message: "Waiting")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                // Put your code which should be executed with a delay here
                self.shakeOutlet.stopAnimating()
                self.shakeOutlet.isHidden = true
                let number = Int.random(in: 0 ... 14)
                self.cookieImage.image = self.opened_Cookie
                if self.cookiesDB[number].cookieType == "Positive" {
                    
                   self.cookieMessageResult.text = self.cookiesDB[number].cookieMessage
                   self.cookieMessageResult.textColor = UIColor.blue
                } else if self.cookiesDB[number].cookieType == "Negative" {
                    self.cookieMessageResult.text = self.cookiesDB[number].cookieMessage
                    self.cookieMessageResult.textColor = UIColor.orange
                    
                }
               // self.cookieMessageResult.text = self.cookiesDB[number].cookieMessage
                self.messageType = self.cookiesDB[number].cookieType
                self.newCookieDate.text = dateFormatter.string(from: dateTest)
                self.saveButton.isHidden = false
                self.isShake = true
            })

            } else if isShake == true {
                print("Already shaked,do nothing!")
            }
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
        
        let newCookie_Result = cookieMessageResult.text ?? ""
        let newCookie_Photo =  UIImage(named:"Open-CookieIMG")
        let newCookie_DateTime = newCookieDate.text ?? ""
       
        
       // let testPhoto = UIImage(named:"Open-CookieIMG") newCookie_Result
        
        newCookie = Result(cookiePhoto: newCookie_Photo, result: newCookie_Result, datetime: newCookie_DateTime, type: messageType)
        
    }
    
    
  

}
