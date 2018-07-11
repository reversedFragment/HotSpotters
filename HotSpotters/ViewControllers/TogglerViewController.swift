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
        // Do any additional setup after loading the view.
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

}
