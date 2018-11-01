//
//  AddDeleteViewController.swift
//  com.egco428.a13342
//
//  Created by Kanta'MacPro on 31/10/2561 BE.
//  Copyright © 2561 Kanta'MacPro. All rights reserved.
//

import UIKit

class AddDeleteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    var editCookies = [Result]()
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editCookies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "messageCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageTableViewCell else {
            fatalError("The dequeued cell is not an instance of MessageTableViewCell")
        }
        
        //Fetch the appropriate result for the data source layout.
        let Edit_cookies = editCookies[indexPath.row]
        // cell.message.text = Edit_cookies.result
        cell.message.text = "Hello!"
        cell.type.text = "Positive"
        
        
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
       // loadSampleMessage()

        // Do any additional setup after loading the view.
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
