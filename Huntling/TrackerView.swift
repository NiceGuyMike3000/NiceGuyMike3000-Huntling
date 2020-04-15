//
//  TrackerView.swift
//  Huntling
//
//  Created by Michael Schilling on 15.04.20.
//  Copyright © 2020 Michael Schilling. All rights reserved.
//

import SwiftUI

struct TrackerView: View {
    
    //let tracker1 = Tracker(name: "1", city: "Aa", plz: "12345", phoneNumber: 1)
    
    let tra: Tracker
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            VStack(alignment: .leading) {
                
                Text(tra.name).font(.headline)
                // post time
                Text(tra.plz).font(.subheadline)
                
            }
            .padding(.top, 5)
            // name
            
            // Add a call-Button
            
        }
        
        /*
        VStack(alignment: .leading) {
            
            HStack(spacing: 10) {
                
                VStack(alignment: .leading) {
                    
                    Text(tra.name).font(.headline)
                    // post time
                    Text(tra.plz).font(.subheadline)
                    
                }
                .padding(.top, 5)
                // name
                
            }
            
        }
        .padding(.top, 5)
        */
    }
    
}

/*
struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        
        let tracker1 = Tracker(name: "1", city: "Aa", plz: "12345", phoneNumber: 1)
        
        TrackerView(tra: tracker1)
        
    }
}
*/

