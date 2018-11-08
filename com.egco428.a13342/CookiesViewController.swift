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
        storeCookieMessageAndType()
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
    private func storeCookieMessageAndType(){
        guard let messageDB_1 = MessageDB(cookieMessage: "Today it's up to you to create the peacefulness you long for.", cookieType: "Positive") else {
            fatalError("Error Message1")
        }
        guard let messageDB_2 = MessageDB(cookieMessage: "A friend asks only for your time not your money.", cookieType: "Positive") else {
            fatalError("Error Message2")
        }
        guard let messageDB_3 = MessageDB(cookieMessage: "If you refuse to accept anything but the best, you very often get it.", cookieType: "Positive") else {
            fatalError("Error Message3")
        }
        guard let messageDB_4 = MessageDB(cookieMessage: "A smile is your passport into the hearts of others.", cookieType: "Positive") else {
            fatalError("Error Message4")
        }
        guard let messageDB_5 = MessageDB(cookieMessage: "A good way to keep healthy is to eat more Chinese food.", cookieType: "Positive") else {
            fatalError("Error Message5")
        }
        guard let messageDB_6 = MessageDB(cookieMessage: "Your high-minded principles spell success.", cookieType: "Positive") else {
            fatalError("Error Message6")
        }
        guard let messageDB_7 = MessageDB(cookieMessage: "You learn from your mistakes... You will learn a lot today.", cookieType: "Negative") else {
            fatalError("Error Message7")
        }
        guard let messageDB_8 = MessageDB(cookieMessage: "Your shoes will make you sad today.", cookieType: "Negative") else {
            fatalError("Error Message8")
        }
        guard let messageDB_9 = MessageDB(cookieMessage: "The man or woman you desire feels the same about you.", cookieType: "Positive") else {
            fatalError("Error Message9")
        }
        guard let messageDB_10 = MessageDB(cookieMessage: "A dream you have will come true.", cookieType: "Positive") else {
            fatalError("Error Message10")
        }
        guard let messageDB_11 = MessageDB(cookieMessage: "Serious trouble will bypass you.", cookieType: "Negative") else {
            fatalError("Error Message11")
        }
        guard let messageDB_12 = MessageDB(cookieMessage: "Now is the time to try something new.", cookieType: "Negative") else {
            fatalError("Error Message12")
        }
        guard let messageDB_13 = MessageDB(cookieMessage: "Wealth awaits you very soon.", cookieType: "Positive") else {
            fatalError("Error Message13")
        }
        guard let messageDB_14 = MessageDB(cookieMessage: "Jealousy doesn't open doors, it closes them!", cookieType: "Negative") else {
            fatalError("Error Message14")
        }
        guard let messageDB_15 = MessageDB(cookieMessage: "It's better to be alone sometimes.", cookieType: "Negative") else {
            fatalError("Error Message15")
        }
        
        
        cookiesDB += [messageDB_1,messageDB_2,messageDB_3,messageDB_4,messageDB_5,messageDB_6,messageDB_7,messageDB_8,messageDB_9,messageDB_10
        ,messageDB_11,messageDB_12,messageDB_13,messageDB_14,messageDB_15]
        
       
    }
    
  
    

}
