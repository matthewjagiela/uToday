//
//  siriSetupViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/25/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class siriSetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .clear
        
        navigationController?.navigationBar.isUserInteractionEnabled = false
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    @IBAction func nextButton(_ sender: Any) {
        let savedData = LocalDataHandler()
        savedData.setupDone()
        //self.performSegue(withIdentifier: "setupDone", sender: self)
        switchScreen()
    }
    func switchScreen() {
        self.performSegue(withIdentifier: "stageThree", sender: self)
        
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
