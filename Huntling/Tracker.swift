//
//  Tracker.swift
//  Huntling
//
//  Created by Michael Schilling on 16.04.20.
//  Copyright © 2020 Michael Schilling. All rights reserved.
//

import Foundation


struct Tracker: Identifiable {
    
    var id: String = UUID().uuidString
    let name: String
    let city: String
    let plz: String
    let phoneNumber: String
    
    init(name: String, city: String, plz: String, phoneNumber: String) {
        self.name = name
        self.city = city
        self.plz = plz
        self.phoneNumber = phoneNumber
    }
    
}
