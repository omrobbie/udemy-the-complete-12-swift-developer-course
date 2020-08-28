//
//  DateTimeHelpers.swift
//  TimeTracker WatchKit Extension
//
//  Created by omrobbie on 28/08/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

func getCurrentClockInString(date1: Date, date2: Date) -> String {
    let timeInterval = Int(date1.timeIntervalSince(date2))
    let hours = timeInterval / 3600
    let minutes = (timeInterval % 3600) / 60
    let seconds = timeInterval % 60

    var currentClockInString = ""

    if hours != 0 {
        currentClockInString += "\(hours)h "
    }

    if minutes != 0 || hours != 0 {
        currentClockInString += "\(minutes)m\n"
    }

    currentClockInString += "\(seconds)s"
    return currentClockInString
}
