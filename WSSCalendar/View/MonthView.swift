//
//  MonthView.swift
//  WSSCalendar
//
//  Created by woong on 14/11/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

protocol MonthViewDelegate {
    
    func didTapPreviousMonth(_ date: Date) -> Date
    func didTapNextMonth(_ date: Date) -> Date
    
}

class MonthView: UIView {

    var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    var delegate: MonthViewDelegate?
    var presentDate = Date()
    var currentYear: Int = 0
    var currentMonth: Int = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        setupViews()
        
        currentYear = Calendar.current.component(.year, from: presentDate)
        currentMonth = Calendar.current.component(.month, from: presentDate)
        
        lblName.text = "\(currentYear) \(monthsArr[currentMonth-1])"
    }
    
    @objc func btnLeftRightAction(sender: UIButton) {
        
        guard let delegate = delegate else {return}
        
        if sender == btnRight {
            self.presentDate = delegate.didTapNextMonth(presentDate)
        } else {
            self.presentDate = delegate.didTapPreviousMonth(presentDate)
        }
        currentYear = Calendar.current.component(.year, from: presentDate)
        currentMonth = Calendar.current.component(.month, from: presentDate)
        
        lblName.text = "\(currentYear) \(monthsArr[currentMonth-1])"
    }
    
    func setupViews() {
        self.addSubview(btnLeft)
        btnLeft.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(), size: CGSize(width: 50, height: 0))
        btnLeft.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        self.addSubview(btnRight)
        btnRight.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: .init(), size: CGSize(width: 50, height: 0))
        btnRight.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        self.addSubview(lblName)
        lblName.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: btnLeft.trailingAnchor, bottom: nil, trailing: btnRight.leadingAnchor, padding: .init(), size: CGSize(width: 0, height: self.frame.height))
        lblName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    
    let lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
//        let year = Calendar.current.component(.year, from: Date())
//        let month = Calendar.current.component(.month, from: Date())
//        lblName.text = "\(year) \(MonthView.monthsArr[month-1])"
        return label
        
    }()
    
    let btnLeft: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("<", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    let btnRight: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(">", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
        return button
    }()

}
