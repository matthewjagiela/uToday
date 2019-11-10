//
//  IntentHandler.swift
//  TodayIntent
//
//  Created by Matthew Jagiela on 4/1/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        guard intent is MyDayIntent else {
            fatalError("Unhandled intent type \(intent)")
        }
        return MyDayIntentHandler()
    }
    
}
