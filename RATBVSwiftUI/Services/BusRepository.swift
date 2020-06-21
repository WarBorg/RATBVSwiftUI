//
//  BusRepository.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 01/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import Resolver

protocol BusRepository {
    
    func getBusLines(isForcedRefresh: Bool) -> [BusLine]
    
    func getBusStations(busLineId: Int, directionLink: String, direction: String, isForcedRefresh: Bool) -> [BusStation]
    
    func getBusTimetables(busStationId: Int, schedualLink: String, isForcedRefresh: Bool) -> [BusTimetable]
    
    func downloadAllStationsTimetables(busLineId: Int, normalDirectionLink: String, reverseDirectionLink: String)
}

class BusRepositoryImpl : BusRepository {
    @Injected private var busWebService: BusWebService
    
    func getBusLines(isForcedRefresh: Bool) -> [BusLine] {
        return []
    }
    
    func getBusStations(busLineId: Int, directionLink: String, direction: String, isForcedRefresh: Bool) -> [BusStation] {
        return []
    }
    
    func getBusTimetables(busStationId: Int, schedualLink: String, isForcedRefresh: Bool) -> [BusTimetable] {
        return []
    }
    
    func downloadAllStationsTimetables(busLineId: Int, normalDirectionLink: String, reverseDirectionLink: String) {
        
    }
}
