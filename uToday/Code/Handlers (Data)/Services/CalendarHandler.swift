//
//  CalanderHandler.swift
//  uToday
//
//  Created by Matthew Jagiela on 2/20/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit
import EventKit
class CalendarHandler: NSObject {
    let eventStore = EKEventStore()
    var events = [EKEvent]()
    override init() {
        print("Init")
        let now = Date()
        let calendar = Calendar.current
        var dateComponenets = DateComponents()
        dateComponenets.day = 1
       //let startDate = calendar.date(bySettingHour: calendar.component(.hour, from: now), minute: calendar.component(.minute, from: now), second: calendar.component(.second, from: now), of: now) //This makes the start date right now so
        let endDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: now) //End of day
        
        let eventPredicate = self.eventStore.predicateForEvents(withStart: now, end: endDate!, calendars: nil) //The time frame we are looking for
        
        events = self.eventStore.events(matching: eventPredicate) //All of the events from now till end of day
        
        //LOGGING:
        /**
        for event in events { //DEBUG: For each event tell us about it
            
            print("DEBUG: CALENDAR: \(event.title) DATE: \(event.startDate), \(event.calendar.cgColor)")
            print("DEBUG: CALENDAR EVENT: \(event.isAllDay)")
        }
 **/
        
    }
    
    func requestCalenderAccess() -> Bool {
        var isGranted = false
        eventStore.requestAccess(to: .event) { (granted, _) in
            if granted {
                isGranted = true
            }
        }
        return isGranted
    }
    func getNewestColor() -> CGColor {
        return events[0].calendar.cgColor
    }
    func getSummary() -> String {
        if events.isEmpty {
            return "You have no more appointments today!"
        } else {
            for event in events where !event.isAllDay {
                return "Your next event is \(event.title ?? "") at \(getEventStartDate(event))"
            }
        }
        return ""
    }
    func getEvents() -> [EKEvent] { //This is going to return all of the events out of every calendar for the day...
        return events
    }
    func getEventName(_ index: Int) -> String {
        return events[index].title //This is going to return the name of the event that is at index... Use this for tables and siri.
    }
    func getEventStartDate(_ index: Int) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "h:mm a"
        return "\(dateFormat.string(from: events[index].startDate))"
    }
    func getEventStartDate(_ event: EKEvent) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "h:mm a"
        return dateFormat.string(from: event.startDate)
    }
    func getCalendarTitle(_ index: Int) -> String {
        return events[index].calendar.title
    }
    func getEventColor(_ index: Int) -> UIColor {
        return UIColor(cgColor: events[index].calendar.cgColor)
    }

}
