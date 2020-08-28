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

        return "Error get current period"
    }

    func stringFromDates(date1: Date, date2: Date) -> String {
        var theString = ""
        let cal = Calendar.current.dateComponents([.hour, .minute, .second], from: date1, to: date2)

        guard let hour = cal.hour,
            let minute = cal.minute,
            let second = cal.second
            else {
                return "Error get date components"
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

    func prettyDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        return formatter.string(from: date)
    }

    func prettyInDate() -> String {
        if let inDate = inDate {
            return prettyDate(date: inDate)
        }
        return "Error formating in date"
    }

    func prettyOutDate() -> String {
        if let outDate = outDate {
            return prettyDate(date: outDate)
        }
        return "Error formating out date"
    }

    func time() -> TimeInterval {
        if let inDate = inDate {
            if let outDate = self.outDate {
                return outDate.timeIntervalSince(inDate)
            } else {
                return Date().timeIntervalSince(inDate)
            }
        }

        return 0.0
    }
}
