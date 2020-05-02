//
//  TrackerData.swift
//  Huntling
//
//  Created by Michael Schilling on 25.04.20.
//  Copyright © 2020 Michael Schilling. All rights reserved.
//

import Foundation

struct TrackerData: Codable {
    
    var id: String
    var name: String
    //var city: String
    var district: String
    var plz: String
    var phoneNumber: String
    var latitude: Double
    var longitude: Double
    
}
