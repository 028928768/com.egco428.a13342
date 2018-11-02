//
//  AddDeleteViewController.swift
//  com.egco428.a13342
//
//  Created by Kanta'MacPro on 31/10/2561 BE.
//  Copyright © 2561 Kanta'MacPro. All rights reserved.
//

import UIKit
import os.log

class AddDeleteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
  //  var editCookies = [Result]()
    var results = [Result]()
    
    //Picker Outlets
    @IBOutlet var typeButtons: [UIButton]!
    @IBOutlet weak var selectTypeButton: UIButton!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "messageCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageTableViewCell else {
            fatalError("The dequeued cell is not an instance of MessageTableViewCell")
        }
        
        //Fetch the appropriate result for the data source layout.
       // let Edit_cookies = editCookies[indexPath.row]
        let result = results[indexPath.row]
        // cell.message.text = Edit_cookies.result
        cell.message.text = result.result
        cell.type.text = result.type
        
//        if result.type == "Positive" {
//            cell.fortuneResult.text = result.result
//            cell.fortuneResult.textColor = UIColor.blue
//        } else if result.type == "Negative" {
//            cell.fortuneResult.text = result.result
//            cell.fortuneResult.textColor = UIColor.orange
//        } else {
//            cell.fortuneResult.text = result.result
//        }
//
//        cell.fortuneDateTime.text = result.datetime
        
        
       // cell.cookieImage.image = result.cookiePhoto
        
        
        return cell
        
    }
    
    
    //saveCookies to database
    private func saveCookies() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(results, toFile: Result.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    //save
    private func loadCookies() -> [Result]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Result.ArchiveURL.path) as? [Result]
    }
    
    // Type Selector action
    @IBAction func handleSelection(_ sender: UIButton) {
        typeButtons.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations: {
                 button.isHidden = !button.isHidden
                 self.view.layoutIfNeeded()
            })
          
    }
    }
    //type tapped
    
    enum Types : String {
        case Positive = "Positive"
        case Negative = "Negative"
    }
    
    @IBAction func typeTapped(_ sender: UIButton) {
        guard  let title = sender.currentTitle, let type = Types(rawValue: title) else {
            return
        }
        
        switch  type {
        case .Negative:
            selectTypeButton.setTitle("Negative", for: .normal)
            typeButtons.forEach{ (button) in
                UIView.animate(withDuration: 0.3, animations: {
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                })
            }
           // print("Negative")
        default:
            selectTypeButton.setTitle("Positive", for: .normal)
            typeButtons.forEach{ (button) in
                    UIView.animate(withDuration: 0.3, animations: {
                        button.isHidden = !button.isHidden
                        self.view.layoutIfNeeded()
                    })
           
            }
            }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let saveCookies = loadCookies(){
            results += saveCookies
        } else {
            //Load sample data
            //loadSampleResults()
            loadCookies()
        }

        
    }
    
//    private func loadSampleMessage(){
//        let photo = UIImage(named: "Open-CookieIMG")
//
//
//        guard let message1 = Result(cookiePhoto: photo, result: "You're Lucky!!", d: "10-October-2018", time: "12:00PM",type: "") else {
//            fatalError("Unable to load result of message1")
//        }
//
//        guard let message2 = Result(cookiePhoto: photo, result: "You will get A", date: "11-October-2018", time: "13:00PM",type: "") else {
//            fatalError("Unable to load result of message2")
//        }
//        guard let message3 = Result(cookiePhoto: photo, result: "Don't panic", date: "12-October-2018", time: "14:00PM",type: "") else {
//            fatalError("Unable to load result of message3")
//        }
//
//        editCookies += [message1,message2,message3]
//    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
