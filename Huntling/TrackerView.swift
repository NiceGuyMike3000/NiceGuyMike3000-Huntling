//
//  TrackerView.swift
//  Huntling
//
//  Created by Michael Schilling on 15.04.20.
//  Copyright © 2020 Michael Schilling. All rights reserved.
//

import SwiftUI

struct TrackerView: View {
    
    
    let tra: Tracker
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            VStack(alignment: .leading) {
                
                Spacer()
                Text(tra.name).font(.headline)
                Spacer()
                Text(tra.plz).font(.subheadline)
                Spacer()
            }
            
            Spacer()
            
            Button(action: {

                //let number: String = String(self.tra.phoneNumber)
                
                let number: String = self.tra.phoneNumber
                
                guard let url = URL(string: "tel://" + number) else { return }
                
                if UIApplication.shared.canOpenURL(url) {
                    //print("Ho")
                    UIApplication.shared.open(url)
                } else {
                    // print("Hi")
                }
                
            }) {
                
                Spacer()
                
                Image(systemName: "phone.circle")
                .font(.largeTitle)
                .foregroundColor(.blue)
                
                Spacer()
                
            }
            
        }
        
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

