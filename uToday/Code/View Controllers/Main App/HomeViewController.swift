//
//  HomeViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 3/21/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return services.getAmountOfServices()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "module", for: indexPath) as! ModuleTableViewCell
        
        // Configure the cell... : This is going to change because there is going to be a custom cell for modules, this is to test the table
        /**
         cell.layer.cornerRadius = 5
         cell.layer.borderWidth = 2
         cell.layer.borderColor = UIColor.white.cgColor
         
         **/
        services.setService(services.getServices(indexPath.section))
        cell.nameOfService.text = services.serviceName()
        cell.summary.text = services.getServiceSummary()
        cell.pictureOfService.image = services.getServiceImage()
        cell.imageView?.contentMode = .scaleAspectFill
        
        cell.imageView?.clipsToBounds = true
        
        cell.backgroundColor = .clear //Make it so we can see the background image through the cell
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { //This is going to make the spacing between cards
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { // This is how much space we want between the cards
        return 5
    }
    
    
    
    
    let services = ServiceHandler() //This is going to be so we can manage all the services within the app on this controller

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .red
        //self.view = UIImageView(image: UIImage(named:"Main Selection Background.png"))
        services.loadingDone {
            self.tableView.reloadData()
            
        }
        tableView.rowHeight = 143
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
        
        
    }
    @objc func userDefaultsDidChange(_ notification: Notification) {
        print("MAIN VIEW STUFF CHANGED")
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .clear
        navigationController?.navigationBar.barStyle = .default
        
        navigationController?.navigationBar.isUserInteractionEnabled = false
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        self.setNeedsStatusBarAppearanceUpdate()
        
        //Tab  Bar Hiding:
        
        tabBarController?.tabBar.backgroundImage = UIImage()
        tabBarController?.tabBar.shadowImage = UIImage()
        tabBarController?.tabBar.barStyle = .default
        //tabBarController?.tabBar.tintColor = .black
        tabBarController?.tabBar.isTranslucent = true
        tabBarController?.tabBar.isHidden = false
        
        let tableSelection: IndexPath? = tableView.indexPathForSelectedRow
        if let tableSelection = tableSelection {
            tableView.deselectRow(at: tableSelection, animated: false)
            
        }
        tableView.reloadData()
        
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
