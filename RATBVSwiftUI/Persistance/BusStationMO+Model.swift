//
//  BusStationMO+Model.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 10/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

extension BusStationMO {
    func from(busStation: BusStation) {
        self.id = busStation.id
        self.name = busStation.name
        self.direction = busStation.direction
        self.scheduleLink = busStation.scheduleLink
        self.lastUpdateDate = busStation.lastUpdateDate
    }
}
