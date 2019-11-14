//
//  Date+.swift
//  WSSCalendar
//
//  Created by woong on 14/11/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import Foundation

extension Date {
    
    private var sunday: Date {
//        let gregorian = Calendar(identifier: .gregorian)
//        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        let sundayComp = Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return Calendar.current.date(from: sundayComp)!
    }
    
    var startOfWeek: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self.sunday)!
    }

    var endOfWeek: Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: self.sunday)!
    }

    var startOfPreviousWeek: Date {
        return Calendar.current.date(byAdding: .day, value: -6, to: self.sunday)!
    }

    var endOfPreviousWeek: Date {
        return Calendar.current.date(byAdding: .day, value: 0, to: self.sunday)!
    }

    var startDateOfMonth: Date {
       return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    var endDateOfMonth: Date {
       return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startDateOfMonth)!
    }

    var getPreviousMonthDate: Date {
       return Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
    
    var getNextMonthDate: Date {
       return Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }

    var startDateOfPreviousMonth: Date {
       return getPreviousMonthDate.startDateOfMonth
    }

    var endOfPreviousMonth: Date {
       return getPreviousMonthDate.endDateOfMonth
    }
    
}
