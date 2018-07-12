//
//  TogglerViewController.swift
//  HotSpotters
//
//  Created by Trevor Adcock on 7/9/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

import UIKit

class TogglerViewController: UIViewController {
    
    @IBOutlet weak var typeToggle: UISegmentedControl!
    @IBOutlet weak var eventsContainerView: UIView!
    @IBOutlet weak var twitterContainerView: UIView!
    @IBOutlet var contentViewPosition: UIPanGestureRecognizer!
    
//    lazy var trendingTableViewController: TrendingTopicsTableViewController = {
//        let trendingTopicsViewController = UIHelper.storyBoard.instantiateViewController(withIdentifier: "trendingTVC") as! TrendingTopicsTableViewController
//        addAsChildViewController(trendingTopicsViewController)
//        return trendingTopicsViewController
//    }()
//
//    lazy var eventCategoriesViewController: EventCategoriesTableViewController = {
//        let categoriesViewController = UIHelper.storyBoard.instantiateViewController(withIdentifier: "categoriesTVC") as! EventCategoriesTableViewController
//        addAsChildViewController(categoriesViewController)
//        return categoriesViewController
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataTypeToggled()
        typeToggle.addTarget(self, action: #selector(dataTypeToggled), for: .valueChanged)
         //Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
//    func addAsChildViewController(_ childViewController: UIViewController){
//        addChildViewController(childViewController)
//        view.addSubview(childViewController.view)
//        childViewController.view.bounds = embedContainerView.bounds
//        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        childViewController.didMove(toParentViewController: self)
//
//    }
    
    let bottomPosition = UIView(frame: CGRect(x: 100.0, y: 100, width: 100, height: 100))
    let middlePosition = UIView(frame: CGRect(x: 150, y: 150, width: 150, height: 150))
    let topPosition = UIView(frame: CGRect(x: 200, y: 200, width: 200, height: 200))
    
    enum postion {
        case bottom
        case middle
        case top
    }
    
    var initialTouchPoint = CGPoint(x: 0, y: 0)
    
    var drawerPosition = postion.bottom
    
    @IBAction func changeDrawer(_ sender: UIPanGestureRecognizer) {
        //guard let parentView = parent as? MapViewController else { return }
        
        let toggleVC = UIHelper.storyBoard.instantiateViewController(withIdentifier: "toggleViewController")
        let mapVC = UIHelper.storyBoard.instantiateViewController(withIdentifier: "mapViewController")
        
        let bottomPosition = CGRect(x: 0, y: mapVC.view.bounds.maxY - (mapVC.view.frame.size.height / 8), width: self.view.frame.size.width, height: self.view.frame.size.height)
        let middlePosition = CGRect(x: 0, y: mapVC.view.bounds.maxY - (mapVC.view.frame.size.height / 2), width: self.view.frame.size.width, height: self.view.frame.size.height)
        let topPosition = CGRect(x: 0, y: mapVC.view.bounds.minY + (80), width: self.view.frame.size.width, height: self.view.frame.size.height)
        let touchPoint = sender.location(in: mapVC.view?.window)
        
//        let bottomPosition = CGRect(x: 0, y: super.view.bounds.maxY - (super.view.frame.size.height / 8), width: self.view.frame.size.width, height: self.view.frame.size.height)
//        let middlePosition = CGRect(x: 0, y: super.view.bounds.maxY - (super.view.frame.size.height / 2), width: self.view.frame.size.width, height: self.view.frame.size.height)
//        let topPosition = CGRect(x: 0, y: super.view.bounds.minY + (80), width: self.view.frame.size.width, height: self.view.frame.size.height)
//        let touchPoint = sender.location(in: super.view?.window)
        
        let touchDistance = touchPoint.y - initialTouchPoint.y
        
        contentViewPosition.minimumNumberOfTouches = 1
        if contentViewPosition.state == .began {
            initialTouchPoint = touchPoint
        } else if sender.state == .changed {
            var x = 0.0
            let evaluateDistance = touchDistance
            print(touchDistance)
            switch evaluateDistance {
                
                //NEGATIVE IS UP
                //POSITIVE IS DOWN
                
            //If the distance of the pan gesture is greater than x and the position is at the bottom, move the drawer to the middle
            case let x where x > -10 && drawerPosition == .bottom:
                drawerPosition = .middle
                print("Moved to middle from bottom")

            //If the distance of the pan gesture is less than x and the position is at the middle, move the drawer to the middle
            case let x where x < -10 && drawerPosition == .middle:
                drawerPosition = .top
                print("Moved to top")

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
        } else if sender.state == .ended || sender.state == .cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    func returnView() -> CGRect {
                        switch self.drawerPosition {
                        case .bottom:
                            return bottomPosition
                        case .middle:
                            return middlePosition
                        case .top:
                            return topPosition
                        }
                    }
                    self.view.frame = returnView()
                    
                    //CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
        self.view.needsUpdateConstraints()
        self.view.setNeedsLayout()
        self.view.setNeedsDisplay()
    }

}
