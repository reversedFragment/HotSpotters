//
//  TogglerViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/9/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

protocol TogglerViewControllerDelegate: class{
    func moveDrawer(to frame: CGRect, completion: (() -> Void)?)
    
    func deselectCollegeAnnotation()
}

enum Position {
    
    case bottom
    case middle
    case top
}

class TogglerViewController: UIViewController {
    
    @IBOutlet weak var containerViewTopContraint: NSLayoutConstraint!
    @IBOutlet weak var typeToggle: UISegmentedControl!
    @IBOutlet weak var typeTogglerView: UIView!
    @IBOutlet weak var eventsContainerView: UIView!
    @IBOutlet weak var twitterContainerView: UIView!
    @IBOutlet weak var fourSquareContainerView: UIView!
    @IBOutlet var panGuestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var closeDrawerButton: UIButton!
    
    weak var delegate: TogglerViewControllerDelegate?
    var mapVC: CollegeMapViewController!
    var topContraint: NSLayoutConstraint?
    var selectedCollege: College?
    
    static let hideTypeTogglerNotification = Notification.Name(rawValue: "Hide the Type Toggler")
    static let showTypeTogglerNotification = Notification.Name(rawValue: "Show the Type Toggler")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTypeToggled()
        addEventListeners()
         //Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataTypeToggled()
        mapVC = parent as? CollegeMapViewController
        self.delegate = mapVC
    }
    
    @objc func dataTypeToggled(){
        switch typeToggle.selectedSegmentIndex {
        case 0:
            twitterContainerView.isHidden = false
            eventsContainerView.isHidden = true
            fourSquareContainerView.isHidden = true
        case 1:
            twitterContainerView.isHidden = true
            eventsContainerView.isHidden = false
            fourSquareContainerView.isHidden = true
        case 2:
            twitterContainerView.isHidden = true
            eventsContainerView.isHidden = true
            fourSquareContainerView.isHidden = false
        default:
            twitterContainerView.isHidden = true
            eventsContainerView.isHidden = false
            fourSquareContainerView.isHidden = true
        }
    }
    
    func getDrawerFrameWithPosition(_ position: Position) -> CGRect {
        
        let bottomPosition = CGRect(x: 0, y: (mapVC.view.bounds.maxY) - (48), width: self.view.frame.size.width, height: self.view.frame.size.height)
        let middlePosition = CGRect(x: 0, y: (mapVC.view.bounds.maxY) - (mapVC.view.frame.size.height / 2), width: self.view.frame.size.width, height: mapVC.view.frame.size.height / 2)
        let topPosition = CGRect(x: 0, y: (mapVC.view.bounds.minY + 32), width: self.view.frame.size.width, height: (mapVC.view.frame.size.height - 32))
        
        switch position{
        case .bottom:
            return bottomPosition
        case .middle:
            return middlePosition
        case .top:
            return topPosition
        }
    }
    
    
    var initialTouchPoint = CGPoint(x: 0, y: 0)
    
    var drawerPosition = Position.bottom
    
    @IBAction func changeDrawer(_ panGestureRecognizer: UIPanGestureRecognizer) {
        //guard let parentView = parent as? MapViewController else { return }

        let touchPoint = panGestureRecognizer.location(in: mapVC.view?.window)
        
        let touchDistance = touchPoint.y - initialTouchPoint.y
        panGuestureRecognizer.minimumNumberOfTouches = 1
        
        if panGuestureRecognizer.state == .began {
            initialTouchPoint = touchPoint
        }
        
        if panGestureRecognizer.state == .changed {
            
            var x = 0.0
            
            let evaluateDistance = touchDistance
            
            print(touchDistance)
            
            switch evaluateDistance {
                
                //NEGATIVE IS UP
                //POSITIVE IS DOWN
                
            //If the distance of the pan gesture is greater than x and the position is at the bottom, move the drawer to the middle
            case let x where x > -10 && drawerPosition == .bottom:
                drawerPosition = .middle

            //If the distance of the pan gesture is less than x and the position is at the middle, move the drawer to the middle
            case let x where x < -10 && drawerPosition == .middle:
                drawerPosition = .top

            //If the distance of the pan gesture is greater than y and the position is at the top, move the drawer to the middle
            case let y where y > 10 && drawerPosition == .top:
                drawerPosition = .middle
                print("Moved to middle from top")

            //If the distance of the pan gesture is less than y and the position is at the middle, move the drawer to the top
            case let y where y < -10 && drawerPosition == .middle:
                //self.view.frame = middlePosition
                drawerPosition = .top
                print("Moved to middle from top")

            //If the distance of the pan gesture is greater than z and the position is at the middle, move the drawer to the bottom
            case let z where z > 10 && drawerPosition == .middle:
                drawerPosition = .bottom

            //If the distance of the pan gesture is greater than x and the position is at the bottom, move the drawer to the middle
            case let z where z < -10 && drawerPosition == .bottom:
                drawerPosition = .middle

            default:
                //self.view.frame = bottomPosition
                print("👈🏼 make me 😃 when 🌌 are ☁️")
            }
        }
        
        if panGestureRecognizer.state == .ended || panGestureRecognizer.state == .cancelled {
                let drawerFrame = getDrawerFrameWithPosition(drawerPosition)
            delegate?.moveDrawer(to: drawerFrame, completion: nil)
        }
    }
    
    @objc func hideTypeToggler(){
//        typeTogglerView.isHidden = true
//        self.twitterContainerView.needsUpdateConstraints()
//        self.twitterContainerView.setNeedsLayout()
//        self.twitterContainerView.setNeedsDisplay()
//        resizeContainerViewOverSegmentSelector()
    }
    
    @objc func showTypeToggler(){
//        typeTogglerView.isHidden = false
//        self.twitterContainerView.needsUpdateConstraints()
//        self.twitterContainerView.setNeedsLayout()
//        self.twitterContainerView.setNeedsDisplay()
//        resizeContainerViewUnderSegmentSelector()
    }
    
    func resizeContainerViewOverSegmentSelector(){
        UIView.animate(withDuration: 0.2) {
            
            self.eventsContainerView.removeConstraint(self.containerViewTopContraint)
            if let topContraint = self.topContraint{
                self.eventsContainerView.removeConstraint(topContraint)
            }
            
            self.eventsContainerView.topAnchor.constraint(equalTo: self.typeTogglerView.topAnchor, constant: 0).isActive = true
            self.eventsContainerView.updateConstraints()
        }
    }
    
    func resizeContainerViewUnderSegmentSelector(){
        UIView.animate(withDuration: 0.2) {
            
            if let topContraint = self.topContraint{
              self.eventsContainerView.removeConstraint(topContraint)
            }
            
            self.topContraint = self.eventsContainerView.topAnchor.constraint(equalTo: self.typeTogglerView.bottomAnchor, constant: 0)
            self.topContraint?.isActive = true
            self.eventsContainerView.updateConstraints()
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        CollegeController.shared.selectedCollege = nil
        universityLabel.text = ""
        let bottomFrame = getDrawerFrameWithPosition(.bottom)
        delegate?.moveDrawer(to: bottomFrame, completion: nil)
        closeDrawerButton.isHidden = true
        removeEventAndVenueAnnotations()
        delegate?.deselectCollegeAnnotation()
    }
    
    @objc func updateCollege(){
        selectedCollege = CollegeController.shared.selectedCollege
        universityLabel.text = selectedCollege?.schoolName
        closeDrawerButton.isHidden = false
        removeEventAndVenueAnnotations()
    }
    
    func addEventListeners(){
        typeToggle.addTarget(self, action: #selector(dataTypeToggled), for: .valueChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(hideTypeToggler), name: TogglerViewController.hideTypeTogglerNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showTypeToggler), name: TogglerViewController.showTypeTogglerNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollege), name: CollegeMapViewController.collegeAnnotationSelected, object: nil)
    }
    
    func removeEventAndVenueAnnotations(){
        NotificationCenter.default.post(name: FourSquareTableViewController.removeAnnotationsNotification, object: nil)
        NotificationCenter.default.post(name: CollegeMapViewController.removeEventAnnotations, object: nil)
    }
}
