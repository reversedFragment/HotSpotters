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
}

enum Position {
    
    case bottom
    case middle
    case top
}

class TogglerViewController: UIViewController {
    
    @IBOutlet weak var typeToggle: UISegmentedControl!
    @IBOutlet weak var eventsContainerView: UIView!
    @IBOutlet weak var twitterContainerView: UIView!
    @IBOutlet var panGuestureRecognizer: UIPanGestureRecognizer!
    
    weak var delegate: TogglerViewControllerDelegate?
    var mapVC: CollegeMapViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapVC = parent?.parent as? CollegeMapViewController
        self.delegate = mapVC
        
        dataTypeToggled()
        typeToggle.addTarget(self, action: #selector(dataTypeToggled), for: .valueChanged)
         //Do any additional setup after loading the view.
    }
    
    @objc func dataTypeToggled(){
        switch typeToggle.selectedSegmentIndex {
        case 0:
            twitterContainerView.isHidden = false
            eventsContainerView.isHidden = true
        case 1:
            twitterContainerView.isHidden = true
            eventsContainerView.isHidden = false
        case 2:
            twitterContainerView.isHidden = false
            eventsContainerView.isHidden = true
        default:
            twitterContainerView.isHidden = false
            eventsContainerView.isHidden = true
        }
    }
    
    func getDrawerFrameWithPosition(_ position: Position) -> CGRect {
        
        let bottomPosition = CGRect(x: 0, y: (mapVC.view.bounds.maxY) - (mapVC.view.frame.size.height / 8), width: self.view.frame.size.width, height: self.view.frame.size.height)
        let middlePosition = CGRect(x: 0, y: (mapVC.view.bounds.maxY) - (mapVC.view.frame.size.height / 2), width: self.view.frame.size.width, height: self.view.frame.size.height)
        let topPosition = CGRect(x: 0, y: (mapVC.view.bounds.minY) + (80), width: self.view.frame.size.width, height: (mapVC.view.frame.size.height - 80))
        
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
        
//        let bottomPosition = CGRect(x: 0, y: super.view.bounds.maxY - (super.view.frame.size.height / 8), width: self.view.frame.size.width, height: self.view.frame.size.height)
//        let middlePosition = CGRect(x: 0, y: super.view.bounds.maxY - (super.view.frame.size.height / 2), width: self.view.frame.size.width, height: self.view.frame.size.height)
//        let topPosition = CGRect(x: 0, y: super.view.bounds.minY + (80), width: self.view.frame.size.width, height: self.view.frame.size.height)
//        let touchPoint = sender.location(in: super.view?.window)
        
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

}
