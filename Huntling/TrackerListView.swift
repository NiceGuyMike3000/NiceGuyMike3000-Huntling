//
//  TrackerListView.swift
//  Huntling
//
//  Created by Michael Schilling on 15.04.20.
//  Copyright © 2020 Michael Schilling. All rights reserved.
//

import SwiftUI

struct TrackerListView : View {
        
    /// posts
    let trackers = TestData.trackers()
    
    /// view body
    var body: some View {
        
        // Provides NavigationController
        NavigationView {
        
                // List inside the navigationController
                List {
                    
                    // loop through all the posts and create a post view for each item
                    ForEach(trackers) { tracker in
                        TrackerView(tra: tracker)
                    }
                    
                }
                .padding(.leading, 0)   // this will removes the left spacing (default is 20)
                .padding(.trailing, 0)  // this will removes the right spacing (default is 20)
                // set navbar title
                .navigationBarTitle(Text("Nachsucheführer"))
        }
        
    }
    
}


struct Tracker: Identifiable {
    
    var id: String = UUID().uuidString
    let name: String
    let city: String
    let plz: String
    let phoneNumber: Int
    
    init(name: String, city: String, plz: String, phoneNumber: Int) {
        self.name = name
        self.city = city
        self.plz = plz
        self.phoneNumber = phoneNumber
    }
    
}


/// Test Data
struct TestData {
    
    /// posts
    static func trackers() -> [Tracker] {
        
        let tracker1 = Tracker(name: "Gustav Löhne", city: "Aachen", plz: "12345", phoneNumber: 1)
        
        let tracker2 = Tracker(name: "Anton Strauch", city: "München", plz: "56455", phoneNumber: 2)
        
        let tracker3 = Tracker(name: "Grav Mag", city: "Hamburg", plz: "12225", phoneNumber: 3)
        
        let tracker4 = Tracker(name: "Sina Cak", city: "Frankfurt", plz: "78900", phoneNumber: 4)
        
        return [tracker1, tracker2, tracker3, tracker4]
        
    }
    
    
}
