//
//  Period.swift
//  Time Ticker
//
//  Created by omrobbie on 28/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Cocoa

extension Period {
    func currentlyPeriod() -> String {
        if let inDate = inDate {
            return stringFromDates(date1: inDate, date2: Date())
        }

        return "Error!"
    }

    func stringFromDates(date1: Date, date2: Date) -> String {
        var theString = ""
        let cal = Calendar.current.dateComponents([.hour, .minute, .second], from: date1, to: date2)

        guard let hour = cal.hour,
            let minute = cal.minute,
            let second = cal.second
            else {
                return "Error!"
        }

        if hour > 0 {
            theString += "\(hour)h \(minute)m "
        } else {
            if minute > 0 {
                theString += "\(minute)m "
            }
        }
        theString += "\(second)s"

        return theString
    }
}
