//
//  InitialViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/24/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var welcomeDescription: UITextView!
    @IBOutlet var firstNameField: UITextField!
    let data = LocalDataHandler()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Let us use the textField methods:
        firstNameField.delegate = self
        //Hide what we do not want:
        firstNameField.alpha = 0.0
        welcomeDescription.alpha = 0.0
        //Disable autolayout constraints for the welcome label:
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = true
        //Alright we want to move the welcome label to the center of the screen:
        welcomeLabel.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        //We are going to use this timer to move the welcome label to the top a second after the app has launched
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.moveWelcome), userInfo: nil, repeats: false)
    }
    @objc func moveWelcome(){ //Move welcome, make objects appear
        UIView.animate(withDuration: 2, animations: { //Animate the movement
            self.welcomeLabel.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.height / 7)
        }) { (moved) in //When it has moved
            UIView.animate(withDuration: 1, animations: { //Animate the appearance of other elements
                self.welcomeDescription.alpha = 1.0
                self.firstNameField.alpha = 1.0
            }, completion: { (shown) in //This doesnt matter
                self.firstNameField.becomeFirstResponder()
            })
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        data.setFirstName(textField.text ?? "Matthew")
        //Transition to the next view....
        self.performSegue(withIdentifier: "stageTwo", sender: self)
        return true
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
