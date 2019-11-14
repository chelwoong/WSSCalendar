//
//  Calendar.swift
//  WSSCalendar
//
//  Created by woong on 14/11/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import Foundation

struct CalendarHelper {
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonthIndex = CalendarHelper.current.component(.month, from: Date())
    var currentYear = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)
    var daysCount = 0
    var dateRowCount = 5
}
