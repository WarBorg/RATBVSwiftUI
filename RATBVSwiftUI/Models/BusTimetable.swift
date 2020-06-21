//
//  BusTimetable.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation

struct BusTimetable : Identifiable, Decodable {
    let id = UUID()
    //let busStationId: UUID
    let hour: String
    let minutes: String
    let timeOfWeek: String
    let lastUpdateDate = "30/09/1985 21:00"
}
