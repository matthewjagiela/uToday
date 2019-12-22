//
//  CalendarViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/20/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let calendar = CalendarHandler()
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("RUN")
        //self.view.backgroundColor = UIColor(cgColor: calendar.getColor())
        summaryLabel.text = calendar.getSummary()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 97
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.hidesBackButton = false
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        tabBarController?.tabBar.isHidden = true
    }
    //Table View Methods:
    func numberOfSections(in tableView: UITableView) -> Int { //This is going to be actually returning the number of modules we are going to store.
        
        return calendar.getEvents().count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { //This is going to make the spacing between cards
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { // This is how much space we want between the cards
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //We only want one per section... This is going to make it so we have the space between modules and no duplicates
        return 1
    }
    //swiftlint:disable force_cast
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //This is the actual module
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! CalendarTableViewCell
        print("Cell \(indexPath.section)")
        var index = indexPath.section
        cell.calendarColor.backgroundColor = calendar.getEventColor(index)
        cell.calendarName.text = calendar.getCalendarTitle(index)
        cell.timeLabel.text = calendar.getEventStartDate(index)
        cell.eventName.text = calendar.getEventName(index)
        
        return cell
    }
    //swiftlint:enable force_cast
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
