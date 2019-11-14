//
//  Month.swift
//  WSSCalendar
//
//  Created by woong on 14/11/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import Foundation

protocol MonthViewDelegate {
    func didChangeMonth(monthIndex: Int, year: Int)
}
