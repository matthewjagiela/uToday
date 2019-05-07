//
//  AddressSetupViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/25/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class WorkAddressSetupViewController: UIViewController,UITextFieldDelegate {
    let data = LocalDataHandler()
    @IBOutlet var streetAddress: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var stateField: UITextField!
    @IBOutlet var zipField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Nothing happens here
        streetAddress.delegate = self
        city.delegate = self
        stateField.delegate = self
        zipField.delegate = self
        streetAddress.becomeFirstResponder() //this is going to make it so the keyboard shows up and the user can just enter info
        
        
        
        //self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else { //This is the last field... If everything is fine then we can say that we can move on... Otherwise we need to do some error correction...
            
            //Testing for completion:
            if(streetAddress.text == ""){
                streetAddress.backgroundColor = UIColor.red
            }
            else if(city.text == ""){
                city.backgroundColor = .red
            }
            else if(stateField.text == ""){
                stateField.backgroundColor = .red
            }
            else if(zipField.text == ""){
                zipField.backgroundColor = .red
            }
            else{ //All Fields valid... Go on to the next step and save the data
                
                data.setWorkAddress(address: "\(streetAddress.text!),\(city.text!),\(stateField.text!),\(zipField.text!)")
                
                self.performSegue(withIdentifier: "stageThree", sender: self)

            }
            
            
        }
        // Do not add a line break
        return false
        
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
