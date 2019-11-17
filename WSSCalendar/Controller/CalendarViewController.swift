//
//  ViewController.swift
//  WSSCalendar
//
//  Created by woong on 25/10/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    // MARK: - Properties
    var collectionViewBottomAnchor: NSLayoutConstraint?
    var contentViewTopAnchorConstraint: NSLayoutConstraint?
    
    var presentDate = Date()
    
    let dateCellId = "dateCellId"

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.isHidden = true
        
        monthView.delegate = self
        dayCollectionView.dataSource = self
        dayCollectionView.delegate = self
        dayCollectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: dateCellId)
        
        setupViews()
        setupGesture()
        
    }
    
    override func viewDidLayoutSubviews() {
        if let flowLayout = dayCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            dayCollectionView.collectionViewLayout.invalidateLayout()
            dayCollectionView.collectionViewLayout = flowLayout
        }
    }
    
    func setupGesture() {
//        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
//        upSwipeGesture.direction = .up
//
//        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
//        downSwipeGesture.direction = .down
//
        
//        self.view.addGestureRecognizer(upSwipeGesture)
//        self.view.addGestureRecognizer(downSwipeGesture)
        
        let longPressGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        
        self.view.addGestureRecognizer(longPressGesture)
    }
    
    // MARK: - Methods
    
    func numberOfWeeksInMonths(_ date: Date) -> Int {
        let weekRange = Calendar.current.range(of: .weekOfMonth,
                                       in: .month,
                                       for: date)
        return weekRange!.count
    }

    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: gesture.view)
        guard let topConstraint = self.contentViewTopAnchorConstraint else {return}
        let newConstraint = topConstraint.constant + translation.y
        
        switch gesture.state {
        case .began:
            print("began, \(translation) ")
        case .changed:
            print("changed, \(topConstraint.constant)")
            if newConstraint > -self.contentView.frame.height && newConstraint < 0 {
                topConstraint.constant = newConstraint
            }
        case .ended:
            if newConstraint < -(self.contentView.frame.height / 2) {
                topConstraint.constant = -self.contentView.frame.height
            } else {
                topConstraint.constant = 0
            }
        default:
            print("")
        }
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        print("swiped")
        
        switch gesture.direction {
        case .up:

            self.dayCollectionView.collectionViewLayout.invalidateLayout()
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .allowAnimatedContent, animations: {
                
                self.contentViewTopAnchorConstraint?.constant = 0
                self.collectionViewBottomAnchor?.constant = -200
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        case .down:

            self.dayCollectionView.collectionViewLayout.invalidateLayout()
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.contentViewTopAnchorConstraint?.constant = 50
                self.collectionViewBottomAnchor?.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
        default:
            contentView.isHidden = true
        }
        
    }
    
    func setupViews() {
        self.view.addSubview(monthView)
        self.view.addSubview(weekdaysView)
        self.view.addSubview(dayCollectionView)
        self.view.addSubview(contentView)
        
        
        monthView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 72))
        
        weekdaysView.anchor(top: monthView.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 50))
        
        dayCollectionView.anchor(top: weekdaysView.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 0))
        
        self.collectionViewBottomAnchor = dayCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        collectionViewBottomAnchor?.priority = UILayoutPriority(750)
        collectionViewBottomAnchor?.isActive = true
        
        contentView.anchor(top: dayCollectionView.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 300))
        self.contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: self.view.bottomAnchor)
        self.contentViewTopAnchorConstraint?.priority = UILayoutPriority(rawValue: 1000)
        self.contentViewTopAnchorConstraint?.isActive = true
        
    }
    
    // MARK: - Views
    let monthView: MonthView = {
        let view = MonthView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    let weekdaysView: WeekdaysView = {
        let view = WeekdaysView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let dayCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        return collectionView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        return view
    }()

}

// MARK: - UICollectionView DataSource
extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(numberOfWeeksInMonths(self.presentDate))
        return 7 * numberOfWeeksInMonths(self.presentDate)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateCellId, for: indexPath) as? DayCollectionViewCell else {return UICollectionViewCell()}
        
        let firstWeekday = Calendar.current.component(.weekday, from: presentDate.startDateOfMonth)
        let lastDayOfMonth = Calendar.current.range(of: .day, in: .month, for: presentDate)!.count
        let presentDay = indexPath.item - firstWeekday + 2
        
        if presentDay > 0 && presentDay <= lastDayOfMonth {
            cell.dayLabel.text = "\(presentDay)"
        } else {
            cell.dayLabel.text = ""
        }
        
        
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension CalendarViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionView Delegate FlowLayout
extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.dayCollectionView.frame.width / 7
        let height = self.dayCollectionView.frame.height / CGFloat(numberOfWeeksInMonths(self.presentDate))
        return  .init(width: width, height: height)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: MonthView Delegate
extension CalendarViewController: MonthViewDelegate {
    
    func didTapPreviousMonth(_ date: Date) -> Date {
        self.presentDate = date.getPreviousMonthDate
        self.dayCollectionView.reloadData()
        
        return self.presentDate
    }
    
    func didTapNextMonth(_ date: Date) -> Date {
        self.presentDate = date.getNextMonthDate
        self.dayCollectionView.reloadData()
        
        return self.presentDate
    }
}
