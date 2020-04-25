//
//  DataLoader.swift
//  Huntling
//
//  Created by Michael Schilling on 25.04.20.
//  Copyright © 2020 Michael Schilling. All rights reserved.
//

import Foundation

public class DataLoader {
    
    @Published var trackerData = [TrackerData]()
    
    init() {
        load()
    }
    
    func load() {
        
        if let fileLocation = Bundle.main.url(forResource: "tracker", withExtension: "json") {
        
            do {
                
                let data = try Data(contentsOf: fileLocation)
                
                let jsonDecoder = JSONDecoder()
                
                let dataFromJson = try jsonDecoder.decode([TrackerData].self, from: data)
                
                self.trackerData = dataFromJson
                
            } catch {
                
                print(error)
                
            }
            
        } else {
            print("Oops")
        }
        
    }
    
}
