//
//  TrackerListView.swift
//  Huntling
//
//  Created by Michael Schilling on 15.04.20.
//  Copyright © 2020 Michael Schilling. All rights reserved.
//

import UIKit

class TrackerListVC : UIViewController {
    
    // 1. Add Use Geo to filter button
    // -> Hide Search when Geo disabled
    // 3. Add Suche nach PLZ
    // 2. Add Trackers
    
    
    var trackersTV: UITableView!

    var trackArr: [Tracker] = []

    var filteredTrackersArr: [Tracker] = []

    let searchController = UISearchController(searchResultsController: nil)

    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        filteredTrackersArr = trackArr.filter({( tracker : Tracker) -> Bool in
            
            let city = tracker.city
            return city.lowercased().contains(searchText.lowercased())
            
        })
        
        trackersTV.reloadData()
    }
    
    
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    
    
    func getTrackers() {
        
        let tracker1 = Tracker(name: "Gustav Löhne", city: "Aachen", plz: "12345", phoneNumber: "1")
        
        let tracker2 = Tracker(name: "Anton Strauch", city: "München", plz: "56455", phoneNumber: "2")
        
        let tracker3 = Tracker(name: "Grav Mag", city: "Hamburg", plz: "12225", phoneNumber: "3")
        
        let tracker4 = Tracker(name: "Sina Cak", city: "Frankfurt", plz: "78900", phoneNumber: "4")
        
        trackArr = [tracker1, tracker2, tracker3, tracker4]
        
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
        
        view.backgroundColor = UIColor.white
        
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
        trackersTV.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        trackersTV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    
    
    
    @objc func handleGeoFilterButton() {
        

        let title: String = "Zugriff auf Standortdaten erteilen?"
        
        let message: String = "Huntling kann mit deiner Erlaubnis deinen Standort nutzen um die Auswahl auf die zuständigen Nachsuchegespanne zu reduzieren"
            
            //. Deine Daten werden dabei nicht dauerhaft gespeichert, mit dritten geteilt und auch nicht in die Cloud übermittelt"
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Not Now", style: .default) { action -> Void in
            // Just dismiss the action sheet
        } )
        
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default) { action -> Void in
            DispatchQueue.main.async {
                
                // Ask permission
                
            }
        } )
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTrackers()

        setup()
        
    }
    

}



extension TrackerListVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filteredTrackersArr.count
        }
        
        return trackArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tracker: Tracker
        
        if isFiltering() {
            tracker = filteredTrackersArr[indexPath.row]
        } else {
            tracker = trackArr[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackerListTVCell", for: indexPath) as! TrackerListTVCell
        
        cell.nameLabel.text = tracker.name
        cell.cityLabel.text = tracker.city
        
        cell.delegate = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(79.5)
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let geoFilterButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Geo Filter aktivieren", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            button.addTarget(self, action: #selector(handleGeoFilterButton), for: .touchUpInside)
            return button
        }()
        
        
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.addSubview(geoFilterButton)
        geoFilterButton.translatesAutoresizingMaskIntoConstraints = false
        geoFilterButton.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        geoFilterButton.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        
        let px = 1 / UIScreen.main.scale
        let line = UIView()
        line.backgroundColor = tableView.separatorColor
        
        v.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        line.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: px).isActive = true
        line.bottomAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
        
        return v
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41
    }
    
    
}



extension TrackerListVC: TrackerListTVCellDelegate {
    
    func didPressCallButton(cell: UITableViewCell) {
        // Add Call Functionality
        //print("Hi")
        
        guard let indexPath: IndexPath = trackersTV.indexPath(for: cell) else { return }
        
        var tracker: Tracker!
        
        if isFiltering() {
            
            tracker = filteredTrackersArr[indexPath.row]
            
        } else {
            
            tracker = trackArr[indexPath.row]
            
        }
        
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



/*
import SwiftUI

struct TrackerListView : View {
        
    /// posts
    let trackers = TestData.trackers()
    
    @State private var searchText : String = ""
    
    /// view body
    var body: some View {
        
        // Provides NavigationController
        NavigationView {
            
            // Search as Header
            // Add Search funct by plz
            
            // SearchBar(text: $searchText)
            
            List {
                
                // loop through all the posts and create a post view for each item
                ForEach(trackers) { tracker in
                    TrackerView(tra: tracker)
                }
                
            }
            .navigationBarTitle(Text("Nachsucheführer"))
            //.padding(.leading, 0)
            //.padding(.trailing, 0)
            
            // set navbar title
            
            
            // Add Toggleble Button to activate geo loc + ActionSheet app & Sys level
            
        }
        
    }
    
}


struct ButtonBox : View {
    
    var body: some View {
        
        Button(action: {

        }) {
            
            Spacer()
            
            /*
            Image(systemName: "phone.circle")
            .font(.largeTitle)
            .foregroundColor(.blue)
            */
            
            Spacer()
    
        }
        
    }
    
}


struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
}
*/


/*
/// Test Data
struct TestData {
    
    /// posts
    static func trackers() -> [Tracker] {
        
        let tracker1 = Tracker(name: "Gustav Löhne", city: "Aachen", plz: "12345", phoneNumber: "1")
        
        let tracker2 = Tracker(name: "Anton Strauch", city: "München", plz: "56455", phoneNumber: "2")
        
        let tracker3 = Tracker(name: "Grav Mag", city: "Hamburg", plz: "12225", phoneNumber: "3")
        
        let tracker4 = Tracker(name: "Sina Cak", city: "Frankfurt", plz: "78900", phoneNumber: "4")
        
        return [tracker1, tracker2, tracker3, tracker4]
        
    }
    
    
}
*/

