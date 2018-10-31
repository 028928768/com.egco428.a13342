//
//  CookieTableViewController.swift
//  com.egco428.a13342
//
//  Created by Kanta'MacPro on 31/10/2561 BE.
//  Copyright © 2561 Kanta'MacPro. All rights reserved.
//

import UIKit

class CookieTableViewController: UITableViewController {

    //MARK: Properties
    var results = [Result]()
    
    //MARK: Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        //Load sample data
        loadSampleResults()
        
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
        
        cell.fortuneResult.text = result.result
        cell.fortuneTime.text = result.time
        cell.fortuneDate.text = result.date
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
            
            
        }
    }
    //MARK: Private Method
    private func loadSampleResults(){
        let photo = UIImage(named: "Open-CookieIMG")
        
        guard let cookie1 = Result(cookiePhoto: photo, result: "You're Lucky!!", date: "10-October-2018", time: "12:00PM") else {
            fatalError("Unable to load result of cookie1")
        }
        
        guard let cookie2 = Result(cookiePhoto: photo, result: "You will get A", date: "11-October-2018", time: "13:00PM") else {
            fatalError("Unable to load result of cookie2")
        }
        guard let cookie3 = Result(cookiePhoto: photo, result: "Don't panic", date: "12-October-2018", time: "14:00PM") else {
            fatalError("Unable to load result of cookie3")
        }
        
        results += [cookie1,cookie2,cookie3]
    }

}
