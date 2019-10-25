//
//  ViewController.swift
//  WSSCalendar
//
//  Created by woong on 25/10/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionViewBottomAnchor: NSLayoutConstraint?
    var contentViewTopAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .orange
        
        setupViews()
        
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
        upSwipeGesture.direction = .up
        
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(gesture:)))
        downSwipeGesture.direction = .down
        
        self.view.addGestureRecognizer(upSwipeGesture)
        self.view.addGestureRecognizer(downSwipeGesture)
        
    }
    
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        print("swiped")
        
        switch gesture.direction {
        case .up:
            
            collectionViewBottomAnchor?.constant = -200
            contentViewTopAnchor?.constant = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        case .down:

            collectionViewBottomAnchor?.constant = 0
            contentViewTopAnchor?.constant = 50
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        default:
            contentView.isHidden = true
        }
        
//        dayCollectionView.bottomAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    func setupViews() {
        self.view.addSubview(monthView)
        self.view.addSubview(weekdaysView)
        self.view.addSubview(dayCollectionView)
        self.view.addSubview(contentView)
        
        
        monthView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 50))
        
        weekdaysView.anchor(top: monthView.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 50))
        
        dayCollectionView.anchor(top: weekdaysView.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 0))
        
        self.collectionViewBottomAnchor = dayCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        collectionViewBottomAnchor?.isActive = true
        
        contentView.anchor(top: nil, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 300))
        self.contentViewTopAnchor = contentView.topAnchor.constraint(equalTo: dayCollectionView.bottomAnchor, constant: 50)
        self.contentViewTopAnchor?.isActive = true
        
//        contentView.frame = CGRect.init(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 200)
//        contentView.topAnchor.constraint(equalTo: dayCollectionView.bottomAnchor, constant: 0).isActive = true
        
        
//        contentView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
//        contentView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
//        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).priority = UILayoutPriority(rawValue: 750)
        
        
        
    }
    
    let monthView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    let weekdaysView: UIStackView = {
        let dayOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
        let weekdaysStackView = UIStackView()
        weekdaysStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for day in dayOfWeek {
            let dayLabel = UILabel()
            dayLabel.text = day
            dayLabel.textAlignment = .center
            weekdaysStackView.addArrangedSubview(dayLabel)
            weekdaysStackView.distribution = .fillEqually
            weekdaysStackView.axis = .horizontal
        }
        
        return weekdaysStackView
    }()
    
    let dayCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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

