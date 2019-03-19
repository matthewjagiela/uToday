//
//  AddressSetupViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/25/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit

class AddressSetupViewController: UIViewController,UITextFieldDelegate {
    let data = LocalDataHandler()
    @IBOutlet var addressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Nothing happens here
        addressField.delegate = self
        
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.text != ""){
            data.setWorkAddress(address: textField.text ?? "275 Mount Carmel Ave, Hamden CT, 06518") //Default will be QU if there is some error with a null value
            self.performSegue(withIdentifier: "stageThree", sender: self)
        }
        
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
