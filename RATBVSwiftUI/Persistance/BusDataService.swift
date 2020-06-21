//
//  BusDataService.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation

protocol BusDataService {
    
    func countBusLines() -> Int
    func getBusLines() -> [BusLineModel]
    func insertBusLines(busLines: [BusLineModel])
    
    func countBusStationsByBusLineIdAndDirection(busLineId: Int, direction: String) -> Int
    func getBusStationsByBusLineIdAndDirection(busId: Int, direction: String) -> [BusStationModel]
    func insertBusStations(busStations: [BusStationModel])
    
    func countBusTimeTableByBusStationId(busStationId: Int) -> Int
    func getBusTimeTableByBusStationId(busStationId: Int) -> [BusTimeTableModel]
    func insertBusTimeTables(busTimeTables: [BusTimeTableModel])
}
