//
//  ContentViewController.swift
//  HotSpotters
//
//  Created by CELLFiY on 7/5/18.
//  Copyright © 2018 Ben Adams. All rights reserved.
//

//import UIKit
//
//class ContentViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        content.delegate = self
//        content.dataSource = self
//
//        // Do any additional setup after loading the view.
//    }
//
//    @IBOutlet weak var content: UICollectionView!
//
//    @IBOutlet weak var filter: UISegmentedControl!
//    @IBAction func filterCategory(_ sender: Any) {
//
//        switch filter.selectedSegmentIndex {
//        case 0:
//            //content.dataSource = Events
//            content.reloadData()
//        case 1:
//            //content.dataSource = Trending
//            print("Two")
//            content.reloadData()
//        case 2:
//            //content.dataSource = Places
//            print("Three")
//            content.reloadData()
//        default:
//            print("Four")
//        }
//
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//
//}

//extension ContentViewController: UICollectionViewDelegate {
//
//}
//
//extension ContentViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch filter.selectedSegmentIndex {
//        case 0:
//            return TrendController.shared.currentTrends.count
//        case 1:
//            return EventBriteController.shared.myEvents.count
//        case 2:
//            return EventBriteController.shared.myEvents.count
//        default:
//            return TrendController.shared.currentTrends.count
//        }
//    }

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch filter.selectedSegmentIndex {
//        case 0:
//              guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as? EventsCollectionViewCell else { return UICollectionViewCell() }
//              let topics = TrendController.shared.currentTrends
//              let topic = topics[indexPath.row]
//            return cell
//        case 1:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as? EventsCollectionViewCell else { return UICollectionViewCell() }
//            let events = EventBriteController.shared.myEvents
//            let event = events[indexPath.row]
//            return cell
//        case 2:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as? EventsCollectionViewCell else { return UICollectionViewCell() }
//            let places = GeneralVenueController.shared.fetchedVenues
//            let place = places[indexPath.row]
//            return cell
//        default:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as? EventsCollectionViewCell else { return UICollectionViewCell() }
//            let topics = EventBriteController.shared.myEvents
//            let topic = topics[indexPath.row]
////            return cell
////        }
//    }
//
//
//}
