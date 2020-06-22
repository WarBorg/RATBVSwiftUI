//
//  BusStation.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation

struct BusStation : Identifiable, Decodable {
    let id: UUID?
    let name: String
    var direction: String?
    let scheduleLink: String
    let lastUpdateDate: String?
    
    init(name: String,
         direction: String,
         scheduleLink: String) {
        self.id = UUID()
        self.name = name
        self.direction = direction
        self.scheduleLink = scheduleLink
        self.lastUpdateDate = "30/09/1985 21:00"
    }
    
    init(mo: BusStationMO) {
        self.id = mo.id ?? UUID()
        self.name = mo.name ?? ""
        self.direction = mo.direction ?? ""
        self.scheduleLink = mo.scheduleLink ?? ""
        self.lastUpdateDate = mo.lastUpdateDate ?? ""
    }
}
