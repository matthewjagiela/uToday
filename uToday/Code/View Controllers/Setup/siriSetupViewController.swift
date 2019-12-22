//
//  siriSetupViewController.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/25/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit
import Intents
import IntentsUI
class siriSetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSiriButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .clear
        
        navigationController?.navigationBar.isUserInteractionEnabled = false
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func addSiriButton() { //This is going to make it so the Apple "Add To Siri" button appears...
        let button = INUIAddVoiceShortcutButton(style: .blackOutline)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        self.view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        self.view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        button.addTarget(self, action: #selector(addToSiri(_:)), for: .touchUpInside)
    }
    @objc
    func addToSiri(_ sender: Any) {
        let intent = MyDayIntent() //This is all the data we set up for Siri. This class is from the Intents definition and is generated for us.
        intent.suggestedInvocationPhrase = "What's Happening Today?"
        let shortcut = INShortcut(intent: intent)! //This is going to actually make the shortcut based on all of our class files and definitions that the user is going to want. This includes the GUI file.
        let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        viewController.modalPresentationStyle = .formSheet
        viewController.delegate = (self as INUIAddVoiceShortcutViewControllerDelegate)
        
        present(viewController, animated: true, completion: nil)
        
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
extension siriSetupViewController: INUIAddVoiceShortcutViewControllerDelegate, INUIAddVoiceShortcutButtonDelegate, INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true) {
            
        }
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true) {
            
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
        
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true) { //They did not add it...
            print("Dimissed")
        }
        
    }
    
}
