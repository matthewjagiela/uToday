//
//  VoiceShortcutsManager.swift
//  uToday
//
//  Created by Matthew Jagiela on 4/1/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//
import Foundation
import Intents

@available(iOS 12.0, *)
public class VoiceShortcutsManager {
    
    private var voiceShortcuts: [INVoiceShortcut] = [] //An array of all enabled shortcuts (One for now)
    
    public init() {
        updateVoiceShortcuts(completion: nil) //Go and populate the array with voice shortcuts that are enabled...
    }
    
    public func voiceShortcut() -> INVoiceShortcut? { //Actual data on the shortcut
        return voiceShortcuts[0]
    }
    public func updateVoiceShortcuts(completion: (() -> Void)?) { //Populate the array with ALL shortcuts from this  particular app. As of right now we are only planning one but we need this to make easy mopdifications in our App
        print("UPDATING")
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { (voiceShortcutsFromCenter, error) in
            guard let voiceShortcutsFromCenter = voiceShortcutsFromCenter else {
                if let error = error {
                    print("Failed to fetch voice shortcuts with error: \(error.localizedDescription)") //There was an error
                }
                return
            }
            print("UPDATE SHORTCUTS SIZE: \(self.voiceShortcuts.count)") //This should always be 0 (if for some reason the user doesn't want to use siri) or 1
            self.voiceShortcuts = voiceShortcutsFromCenter //populate
            if let completion = completion {
                completion() //Completed...
            }
        }
    }
    public func siriEnabled() -> Bool { //Tell me if siri is enabled or not...
        
        if !voiceShortcuts.isEmpty {
            return true
        } else {
            return false
        }
    }
    
}
