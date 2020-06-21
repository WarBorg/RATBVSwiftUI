//
//  BusTimetable.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation

struct BusTimetable : Identifiable, Decodable {
    let id: UUID?
    let hour: String
    let minutes: String
    let timeOfWeek: String
    let lastUpdateDate: String?
    
    init(hour: String,
         minutes: String,
         timeOfWeek: String) {
        self.id = UUID()
        self.hour = hour
        self.minutes = minutes
        self.timeOfWeek = timeOfWeek
        self.lastUpdateDate = "30/09/1985 21:00"
    }
    
    init(mo: BusTimetableMO) {
        self.id = mo.id ?? UUID()
        self.hour = mo.hour ?? ""
        self.minutes = mo.minutes ?? ""
        self.timeOfWeek = mo.timeOfWeek ?? ""
        self.lastUpdateDate = mo.lastUpdateDate ?? ""
    }
}
