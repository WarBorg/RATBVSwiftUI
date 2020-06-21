//
//  BusStation.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation

struct BusStation : Identifiable, Decodable {
    let id = UUID()
    //let busLineId: UUID
    let name: String
    let direction: String?
    let scheduleLink: String
    let lastUpdateDate = "30/09/1985 21:00"
}
