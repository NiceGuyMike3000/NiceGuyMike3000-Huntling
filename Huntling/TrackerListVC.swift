//
//  TrackerListView.swift
//  Huntling
//
//  Created by Michael Schilling on 15.04.20.
//  Copyright © 2020 Michael Schilling. All rights reserved.
//

import UIKit
import CoreLocation

class TrackerListVC : UIViewController {
    
    
    // 2. Add Suche nach PLZ
    // 3. Add Search for filter
    // 4. Scrape trackers
    // 5. Add Trackers
    // 6. Implement CoreData
    
    // Add Icons
    
    // Publish
    
    // Go to school
    
    // *: Improve GeoFilter Algo
    
    
    var trackersTV: UITableView!

    var allTrackers: [Tracker] = []
    var geoedTrackers: [Tracker] = []
    
    var displayedTrackers: [Tracker] = []
    
    
    var initialSetupDone: Bool!
    
    var geoFilterActive: Bool!
    
    var locationAvailable: Bool!
    
    
    let geoFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel!.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleGeoFilterButton), for: .touchUpInside)
        return button
    }()
    
    
    var locationManager: CLLocationManager!

    let searchController = UISearchController(searchResultsController: nil)

    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        if searchText == "" {
            
            if geoFilterActive == true {
                
                displayedTrackers = geoedTrackers
                
            } else {
                
                displayedTrackers = allTrackers
                
            }
            
        } else {
            

            if geoFilterActive == true {
                
                displayedTrackers = geoedTrackers.filter({( tracker : Tracker) -> Bool in
                    
                    let city = tracker.city
                    return city.lowercased().contains(searchText.lowercased())
                    
                    // add PLZ search
                })
                
            } else {
                
                displayedTrackers = allTrackers.filter({( tracker : Tracker) -> Bool in
                    
                    let city = tracker.city
                    return city.lowercased().contains(searchText.lowercased())
                    
                    // add PLZ search
                })
                
            }
            
        }
        
        
        
        trackersTV.reloadData()
    }
    
    
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    
    func setToActivate() {
        
        geoFilterButton.setTitle("Geo Filter aktivieren", for: .normal)
        
        geoFilterActive = false
        
        displayedTrackers = allTrackers
        
        trackersTV.reloadData()
    }
    
    
    func setToDeactivate() {
        
        geoFilterButton.setTitle("Deaktivieren", for: .normal)
        
        geoFilterActive = true
        
        displayedTrackers = geoedTrackers
        
        trackersTV.reloadData()
    }
    
    
    func getTrackers() {
        
        let tracker1 = Tracker(name: "Gustav Löhne", city: "Aachen", plz: "12345", phoneNumber: "1", location: CLLocation.init(latitude: 50.774720, longitude: 6.083920))
        
        let tracker2 = Tracker(name: "Anton Strauch", city: "München", plz: "56455", phoneNumber: "2", location: CLLocation.init(latitude: 48.137611, longitude: 11.579940))
        
        let tracker3 = Tracker(name: "Grav Mag", city: "Hamburg", plz: "12225", phoneNumber: "3", location: CLLocation.init(latitude: 53.544030, longitude: 9.989870))
        
        let tracker4 = Tracker(name: "Sina Cak", city: "Frankfurt", plz: "78900", phoneNumber: "4", location: CLLocation.init(latitude: 50.112550, longitude: 8.672040))
        
        let tracker5 = Tracker(name: "Soba Luk", city: "Frankfurt", plz: "78900", phoneNumber: "5", location: CLLocation.init(latitude: 50.112570, longitude: 8.672020))
        
        let tracker6 = Tracker(name: "Jerry Tub", city: "Aachen", plz: "12345", phoneNumber: "6", location: CLLocation.init(latitude: 50.774000, longitude: 6.083940))
        
        allTrackers = [tracker1, tracker2, tracker3, tracker4, tracker5, tracker6]
        
    }
    
    
    
    func setup() {
    
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Suchen"
        navigationItem.searchController = searchController
        navigationItem.title = "Nachsuchegespanne"
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(geoFilterButton)
        geoFilterButton.translatesAutoresizingMaskIntoConstraints = false
        geoFilterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        geoFilterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        geoFilterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        geoFilterButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        let px = 1 / UIScreen.main.scale
        let line = UIView()
        line.backgroundColor = UIColor.gray
        
        view.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        line.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: px).isActive = true
        line.bottomAnchor.constraint(equalTo: geoFilterButton.bottomAnchor).isActive = true
        
        trackersTV = UITableView()
        trackersTV.dataSource = self
        trackersTV.delegate = self
        trackersTV.allowsSelection = false
        trackersTV.alwaysBounceVertical = true
        
        
        trackersTV.register(TrackerListTVCell.self, forCellReuseIdentifier: "TrackerListTVCell")
        
        
        trackersTV.estimatedRowHeight = 50
        trackersTV.rowHeight = UITableView.automaticDimension
        
        
        view.addSubview(trackersTV)
        trackersTV.translatesAutoresizingMaskIntoConstraints = false
        trackersTV.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        trackersTV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        trackersTV.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 0).isActive = true
        trackersTV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        displayedTrackers = allTrackers
        
        trackersTV.reloadData()
        
    }
    
    
    
    
    @objc func handleGeoFilterButton() {
        
        
        if geoFilterActive == true {
            
            displayedTrackers = allTrackers
            
            trackersTV.reloadData()
        
            setToActivate()
            
        } else {
            
            
            if locationAvailable == true {
                
                displayedTrackers = geoedTrackers
                
                trackersTV.reloadData()
                
                setToDeactivate()
                
            } else {
                
                let title: String = "Zugriff auf Standortdaten erteilen?"
                
                let message: String = "Huntling kann mit deiner Erlaubnis deinen Standort nutzen um die Auswahl auf die zuständigen Nachsuchegespanne zu reduzieren"
                    
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                
                alert.addAction(UIAlertAction(title: "Nicht jetzt", style: .default) { action -> Void in
                    // Just dismiss the action sheet
                } )
                
                
                alert.addAction(UIAlertAction(title: "Bestätigen", style: .default) { action -> Void in
                    DispatchQueue.main.async {
                        
                        self.locationManager.requestWhenInUseAuthorization()
                        
                    }
                } )
                
                present(alert, animated: true, completion: nil)
                
            }
            
            
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTrackers()
        
        view.backgroundColor = UIColor.white
        
        initialSetupDone = false
        
        geoFilterActive = false
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000
        
    }
    
    
}



extension TrackerListVC: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        
        if initialSetupDone == false {
            setup()
            initialSetupDone = true
        }
        
        
        switch status {
        
        case .notDetermined:
            
            locationAvailable = false
            setToActivate()
            
        case .restricted:
            
            locationAvailable = false
            setToActivate()

        case .denied:
            
            locationAvailable = false
            setToActivate()
            
        case .authorizedAlways:
            
            locationAvailable = true
            setToDeactivate()
            
            locationManager.startUpdatingLocation()
            
        case .authorizedWhenInUse:
            
            locationAvailable = true
            setToDeactivate()
            
            locationManager.startUpdatingLocation()
            
        @unknown default:
            
            locationAvailable = false
            setToActivate()
            
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let loc = locations[locations.count-1]
        
        // This algo needs work
        var newGeoedTrackers: [Tracker] = []
        
        var i = 0
        
        while i < 5 {
            
            var wasInserted = false
            
            let trkDist = allTrackers[i].location.distance(from: loc)
            
            var j = 0
            
            while j < newGeoedTrackers.count {
                
                if wasInserted == false {
                    
                    let dist = newGeoedTrackers[j].location.distance(from: loc)
                    
                    if trkDist <= dist {
                        
                        newGeoedTrackers.insert(allTrackers[i], at: j)
                        
                        wasInserted = true
                    }
                    
                }
                
                j += 1
            }
            
            if wasInserted == false {
                newGeoedTrackers.insert(allTrackers[i], at: newGeoedTrackers.count)
            }
            
            i += 1
        }
        
        
        while i < allTrackers.count {
            
            var wasInserted = false
            
            let trkDist = allTrackers[i].location.distance(from: loc)
            
            var j = 0
            
            while j < 5 {
                
                if wasInserted == false {
                    
                    let dist = newGeoedTrackers[j].location.distance(from: loc)
                    
                    if trkDist <= dist {
                        newGeoedTrackers.insert(allTrackers[i], at: j)
                        newGeoedTrackers.remove(at: 5)
                        wasInserted = true
                    }
                    
                }
                
                j += 1
            }
            
            i += 1
        }
        
        
        geoedTrackers = newGeoedTrackers
        
        displayedTrackers = geoedTrackers
        
        if geoFilterActive == true {
            trackersTV.reloadData()
        }
        
    }

}



extension TrackerListVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedTrackers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tracker: Tracker = displayedTrackers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackerListTVCell", for: indexPath) as! TrackerListTVCell
        
        cell.nameLabel.text = tracker.name
        cell.cityLabel.text = tracker.plz + " " + tracker.city
        
        cell.delegate = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(79.5)
    }
    
    
}



extension TrackerListVC: TrackerListTVCellDelegate {
    
    func didPressCallButton(cell: UITableViewCell) {
        
        guard let indexPath: IndexPath = trackersTV.indexPath(for: cell) else { return }
        
        var tracker: Tracker!
        
        tracker = displayedTrackers[indexPath.row]
        
        if let url = URL(string: "tel://\(tracker.phoneNumber)") {
            UIApplication.shared.open(url)
        }
        
    }
    
}


extension TrackerListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}



