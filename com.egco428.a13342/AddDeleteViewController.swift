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
    var results = [Result]()
    var newCookie: Result?
    var selectedType: String = ""
    var Messages = [MessageDB] ()
    var newMessages: MessageDB?
    
    //Picker Outlets
    @IBOutlet var typeButtons: [UIButton]!
    @IBOutlet weak var selectTypeButton: UIButton!
    @IBOutlet weak var newMessage: UITextField!
    @IBOutlet weak var AddMessageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        
        loadCookieMessages()
        if let saveMessage = loadMessages(){
            Messages += saveMessage
        } else {
            loadMessages()
        }
        AddMessageTableView.delegate = self
        AddMessageTableView.dataSource = self
        
    }
 
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "messageCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageTableViewCell else {
            fatalError("The dequeued cell is not an instance of MessageTableViewCell")
        }
        
        //Fetch the appropriate result for the data source layout.
        let tempMessage = Messages[indexPath.row]
       
       // cell.type.text = result.type
        
        if tempMessage.cookieType == "Positive" {
            cell.message.text = tempMessage.cookieMessage
            cell.message.textColor = UIColor.blue
        } else if tempMessage.cookieType == "Negative" {
            cell.message.text = tempMessage.cookieMessage
            cell.message.textColor = UIColor.orange
        } else {
            cell.message.text = tempMessage.cookieMessage
        }

          cell.type.text = tempMessage.cookieType
        

        return cell
        
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            Messages.remove(at: indexPath.row)
            saveMessages()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    //save Message to MessageDatabase
    private func saveMessages() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject( Messages, toFile: MessageDB.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Cookie Message successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save message...", log: OSLog.default, type: .error)
        }
    }
   
    
    //load Message from MessageDatabase
    private func loadMessages() -> [MessageDB]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: MessageDB.ArchiveURL.path) as? [MessageDB]
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
            selectedType = "Negative"
            selectTypeButton.setTitle("Negative", for: .normal)
            typeButtons.forEach{ (button) in
                UIView.animate(withDuration: 0.3, animations: {
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                })
            }
           // print("Negative")
        default:
            selectedType = "Positive"
            selectTypeButton.setTitle("Positive", for: .normal)
            typeButtons.forEach{ (button) in
                    UIView.animate(withDuration: 0.3, animations: {
                        button.isHidden = !button.isHidden
                        self.view.layoutIfNeeded()
                    })
           
            }
            }
    }
    
    

   
    
    @IBAction func addMessageMethod(_ sender: Any) {
        if newMessage.text == "" {
            print("nil message > do nothing")
        } else {
        print("Add button!")
        // Date Picker
        let dateTest = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm a"
        dateFormatter.locale = Locale(identifier: "th")
        
        
       // let newCookie_Result = newMessage.text ?? ""
        let newMessage_text = newMessage.text ?? ""
        let newCookie_DateTime = dateFormatter.string(from: dateTest)
        let newMessage_type = selectedType
        
         newMessages = MessageDB(cookieMessage: newMessage_text, cookieType: newMessage_type)
         //newCookie = Result(cookiePhoto: newCookie_Photo, result: newCookie_Result, datetime: newCookie_DateTime, type: newCookie_Type)
        
        //Add new row
            let newIndexPath = IndexPath(row: results.count, section: 0)
            Messages.append(newMessages!)
            AddMessageTableView.insertRows(at: [newIndexPath], with: .bottom)
            saveMessages()
            //self.tableview.insertRows(at: [newIndexPath], with: .automatic)
           // tableView.insertRows(at: [newIndexPath], with: .automatic)
            
           
        }
            }
       
       // loadCookies()


    private func loadCookieMessages(){
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
        
        
        Messages += [messageDB_1,messageDB_2,messageDB_3,messageDB_4,messageDB_5,messageDB_6,messageDB_7,messageDB_8,messageDB_9,messageDB_10
            ,messageDB_11,messageDB_12,messageDB_13,messageDB_14,messageDB_15]
        
        
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
