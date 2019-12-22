//
//  SettingsViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 4/1/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit
import Intents
import IntentsUI

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var cityBox: UITextField!
    @IBOutlet var zipBox: UITextField!
    @IBOutlet var stateBox: UITextField!
    @IBOutlet var streetBox: UITextField!
    @IBOutlet var firstNameBox: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    var currentTextBox = 2
    let data = LocalDataHandler()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 150)
        //scrollView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        zipBox.delegate = self
        stateBox.delegate = self
        streetBox.delegate = self
        cityBox.delegate = self
        firstNameBox.delegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 150)
    }
    @IBAction func modifySiri(_ sender: Any) {
        let voice = VoiceShortcutsManager()
        voice.updateVoiceShortcuts {
            if voice.siriEnabled() { //We have to edit the phrase
                let editViewController = INUIEditVoiceShortcutViewController(voiceShortcut: voice.voiceShortcut()!)
                editViewController.delegate = self
                self.present(editViewController, animated: true, completion: nil)
                
            } else {
                let intent = MyDayIntent()
                intent.suggestedInvocationPhrase = "What's Happening Today?"
                if let shortcut = INShortcut(intent: intent) {
                    let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
                    viewController.modalPresentationStyle = .formSheet
                    viewController.delegate = self
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        print("CURRENT TEXT BOX \(currentTextBox)")
        if textField.tag == 0 { //Name Field Save The Data
            data.setFirstName(textField.text ?? "Matthew")
        } else if currentTextBox == 5 { //Save and reset
            if streetBox.text?.isEmpty ?? true {
                streetBox.backgroundColor = UIColor.red
            } else if cityBox.text?.isEmpty ?? true {
                cityBox.backgroundColor = .red
            } else if stateBox.text?.isEmpty ?? true {
                stateBox.backgroundColor = .red
            } else if zipBox.text?.isEmpty ?? true {
                zipBox.backgroundColor = .red
            } else { //All Fields valid... Go on to the next step and save the data
                print("SAVING")
                data.setWorkAddress(address: "\(streetBox.text!),\(cityBox.text!),\(stateBox.text!),\(zipBox.text!)")
                textField.resignFirstResponder()
            }
        } else { //Go to the next field
            if let nextField = textField.superview?.viewWithTag(currentTextBox) as? UITextField {
                currentTextBox += 1
                nextField.becomeFirstResponder()
            }
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
extension SettingsViewController: INUIAddVoiceShortcutViewControllerDelegate, INUIAddVoiceShortcutButtonDelegate, INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true) {
            //self.savedData.setSiriEnabled(enabled: true)
            
        }
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true) {
            //self.savedData.setSiriEnabled(enabled: false);
        }
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        self.dismiss(animated: true) {
            
        }
        
    }
    
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        
    }
    
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        
    }
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) { //It has been added
        
        controller.dismiss(animated: true) {
            print("Dismissed")
        }
        //savedData.setSiriEnabled(enabled: true);
        
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true) { //They did not add it...
            print("Dimissed")
        }
        
    }
    
}
