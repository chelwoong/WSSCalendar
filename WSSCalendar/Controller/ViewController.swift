//
//  ViewController.swift
//  WSSCalendar
//
//  Created by woong on 25/10/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables and Properties
    var collectionViewBottomAnchor: NSLayoutConstraint?
    var contentViewTopAnchorConstraint: NSLayoutConstraint?
    
    let dateCellId = "dateCellId"

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.navigationController?.navigationBar.isHidden = true
        
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
    
    // MARK: - Functions

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
    
//    func handlePanChanging(gesutre: UIPanGestureRecognizer) {
//
//        if
//    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        print("swiped")
        
        switch gesture.direction {
        case .up:
            
//            self.view.layoutIfNeeded()
            
            
            self.dayCollectionView.collectionViewLayout.invalidateLayout()
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .allowAnimatedContent, animations: {
                
                self.contentViewTopAnchorConstraint?.constant = 0
                self.collectionViewBottomAnchor?.constant = -200
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        case .down:

//            contentViewTopAnchor?.constant = 50
//            collectionViewBottomAnchor?.constant = 0
//            self.dayCollectionView.reloadData()
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
    let monthView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
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
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collectionView.isScrollEnabled = false
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
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7 * 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dateCellId, for: indexPath) as? DayCollectionViewCell else {return UICollectionViewCell()}
        
//        cell.backgroundColor = .orange
        cell.dayLabel.text = "\(indexPath.item)"
        
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension ViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionView Delegate FlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.dayCollectionView.frame.width / 7
        let height = self.dayCollectionView.frame.height / 6
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
