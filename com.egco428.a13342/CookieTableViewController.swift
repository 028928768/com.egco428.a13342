//
//  CookieTableViewController.swift
//  com.egco428.a13342
//
//  Created by Kanta'MacPro on 31/10/2561 BE.
//  Copyright © 2561 Kanta'MacPro. All rights reserved.
//

import UIKit
import os.log


class CookieTableViewController: UITableViewController {

    //MARK: Properties
    var results = [Result]()
    var cookiesDB = [MessageDB]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        //Load Cookies from Database
        if let saveCookies = loadCookies(){
            results += saveCookies
        } else {
        //Load sample data
        loadSampleResults()
        loadCookies()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "resultCell"
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CookieTableViewCell else {
            fatalError("The dequeued cell is not an instance of CookieTableViewCell")
        }
        
        //Fetch the appropriate result for the data source layout.
        let result = results[indexPath.row]
        
        if result.type == "Positive" {
            cell.fortuneResult.text = result.result
            cell.fortuneResult.textColor = UIColor.blue
        } else if result.type == "Negative" {
            cell.fortuneResult.text = result.result
            cell.fortuneResult.textColor = UIColor.orange
        } else {
            cell.fortuneResult.text = result.result
        }
        
        cell.fortuneDateTime.text = result.datetime
        cell.cookieImage.image = result.cookiePhoto
        

        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            results.remove(at: indexPath.row)
            saveCookies()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
   
    //MARK: Actions
    @IBAction func unwindToCookiesList(sender: UIStoryboardSegue){
        if let sourceViewController =  sender.source as? CookiesViewController,
            let newCookie = sourceViewController.newCookie {
            
            //Add a new Cookies.
            let newIndexPath = IndexPath(row: results.count, section: 0)
            results.append(newCookie)
        
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
            saveCookies()
            
        }
    }
    //MARK: Private Method
    private func loadSampleResults(){
        let photo = UIImage(named: "Open-CookieIMG")
        
        guard let cookies1 = Result(cookiePhoto: photo, result: "You're Lucky!!", datetime: "10-October-2018 12:00PM",type: "Positive") else {
            fatalError("Unable to load result of cookie1")
        }
        
        guard let cookies2 = Result(cookiePhoto: photo, result: "You will get A", datetime: "11-October-2018 13:00PM",type: "Positive") else {
            fatalError("Unable to load result of cookie2")
        }
        guard let cookies3 = Result(cookiePhoto: photo, result: "Don't panic", datetime: "12-October-2018 14:00PM",type: "Negative") else {
            fatalError("Unable to load result of cookie3")
        }
        
        results += [cookies1,cookies2,cookies3]
    }
    
    private func saveCookies() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(results, toFile: Result.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    private func loadCookies() -> [Result]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Result.ArchiveURL.path) as? [Result]
    }
    
    
    
    

}
