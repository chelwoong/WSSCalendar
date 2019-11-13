//
//  WeekdaysView.swift
//  WSSCalendar
//
//  Created by woong on 14/11/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

class WeekdaysView: UIStackView {
    
    let dayOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
    let weekdaysStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for day in dayOfWeek {
            let dayLabel = UILabel()
            dayLabel.text = day
            dayLabel.textAlignment = .center
            self.addArrangedSubview(dayLabel)
            self.distribution = .fillEqually
            self.axis = .horizontal
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
