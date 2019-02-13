//
//  MainViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/5/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit
import CoreLocation //This is going to be removed when we have a setup page

class MainViewController: UITableViewController{
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.view.backgroundColor = .black
        locationManager.requestAlwaysAuthorization() //This needs to be here right now until we have a setup page
        let weather = WeatherHandler()
        tableView.rowHeight = 185 //This is how tall the row is going to be... This can be the same across devices.
        
        
    }
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { //This is going to be actually returning the number of modules we are going to store.
        
        return 2
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { //This is going to make the spacing between cards
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { // This is how much space we want between the cards
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //We only want one per section... This is going to make it so we have the space between modules and no duplicates
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //This is the actual module
        let cell = tableView.dequeueReusableCell(withIdentifier: "module", for: indexPath) as! ModuleTableViewCell

        // Configure the cell... : This is going to change because there is going to be a custom cell for modules, this is to test the table
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.white.cgColor

        return cell
    }
    
    
    
    //ALL OF THIS AS OF RIGHT NOW IS NOT GOING TO MATTER BUT AM GOING TO KEEP IT JUST IN CASE WE WANT TO USE IT IN THE FUTURE
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

}
