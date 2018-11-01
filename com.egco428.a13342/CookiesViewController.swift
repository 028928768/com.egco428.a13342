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
            
            cookieImage.image = opened_Cookie
            resultSQL.text = "New Propercy!!"
            newCookieDate.text = dateFormatter.string(from: dateTest)
            saveButton.isHidden = false
        }
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
        let newCookie_Photo =  cookieImage.image
        let newCookie_DateTime = newCookieDate.text ?? ""
       
        
        let testPhoto = UIImage(named:"Open-CookieIMG")
        
        newCookie = Result(cookiePhoto: testPhoto, result: newCookie_Result, datetime: newCookie_DateTime, type: "")
        
    }
    
  
    

}
