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
    
    func getBusLines(isForcedRefresh: Bool, completion: @escaping ([BusLine]) -> Void)
    
    func getBusStations(busLineId: Int, directionLink: String, direction: String, isForcedRefresh: Bool, completion: @escaping ([BusStation]) -> Void)
    
    func getBusTimetables(busStationId: UUID, schedualLink: String, isForcedRefresh: Bool, completion: @escaping ([BusTimetable]) -> Void)
    
    func downloadAllStationsTimetables(busLineId: Int, normalDirectionLink: String, reverseDirectionLink: String, completion: @escaping () -> Void)
}

class RealBusRepository : BusRepository {
    @Injected private var busDataService: BusDataService
    @Injected private var busWebService: BusWebService
    
    func getBusLines(isForcedRefresh: Bool, completion: @escaping ([BusLine]) -> Void) {
        
        let busLinesCount = self.busDataService.countBusLines()
        
        if isForcedRefresh || busLinesCount == 0 {
            self.busWebService.getBusLines { lines in
                self.busDataService.clearBusLines()
                self.busDataService.insertBusLines(busLines: lines, lastUpdated: Date())
                let currentBusLines = self.busDataService.getBusLines()
                completion(currentBusLines)
            }
        } else {
            let currentBusLines = self.busDataService.getBusLines()
            completion(currentBusLines)
        }
    }
    
    func getBusStations(busLineId: Int, directionLink: String, direction: String, isForcedRefresh: Bool, completion: @escaping ([BusStation]) -> Void) {
        let busStationsCount = self.busDataService.countBusStationsByBusLineIdAndDirection(busLineId: busLineId, direction: direction)
        
        if isForcedRefresh || busStationsCount == 0 {
            self.busWebService.getBusStations(directionLink: directionLink, completion: { stations in
                self.busDataService.clearBusStationsByBusLineId(for: busLineId)
                self.busDataService.insertBusStations(for: busLineId, busStations: stations, lastUpdated: Date())
                
                let currentBusStations = self.busDataService.getBusStationsByBusLineIdAndDirection(busLineId: busLineId, direction: direction)
                completion(currentBusStations)
            })
        } else {
            let currentBusStations = self.busDataService.getBusStationsByBusLineIdAndDirection(busLineId: busLineId, direction: direction)
            completion(currentBusStations)
        }
    }
    
    func getBusTimetables(busStationId: UUID, schedualLink: String, isForcedRefresh: Bool, completion: @escaping ([BusTimetable]) -> Void) {
        let busTimetablesCount = self.busDataService.countBusTimeTableByBusStationId(busStationId: busStationId)
        
        if (isForcedRefresh || busTimetablesCount == 0) {
            self.busWebService.getBusTimetables(scheduleLink: schedualLink,
                                                completion:
                { timeTables in
                    self.busDataService.clearBusTimetablesByBusStationId(for: busStationId)
                    self.busDataService.insertBusTimeTables(for: busStationId, busTimeTables: timeTables, lastUpdated: Date())
                    let currentBusTimetables = self.busDataService.getBusTimeTableByBusStationId(busStationId: busStationId)
                    completion(currentBusTimetables)
            })
        } else {
            let currentBusTimetables = self.busDataService.getBusTimeTableByBusStationId(busStationId: busStationId)
            completion(currentBusTimetables)
        }
    }
    
    func downloadAllStationsTimetables(busLineId: Int, normalDirectionLink: String, reverseDirectionLink: String, completion: @escaping () -> Void) {
        self.busWebService.getBusStations(directionLink: normalDirectionLink)
        { busStationsNormalDirection in
            self.busWebService.getBusStations(directionLink: reverseDirectionLink)
            { busStationsReverseDirection in
                for var station in busStationsNormalDirection {
                    station.direction = "normal"
                }
                for var station in busStationsReverseDirection {
                    station.direction = "reverse"
                }
                let busStations = busStationsNormalDirection + busStationsReverseDirection
                
                self.busDataService.clearBusStationsByBusLineId(for: busLineId)
                self.busDataService.insertBusStations(for: busLineId, busStations: busStations, lastUpdated: Date())
               
                for station in busStations {
                    self.busWebService.getBusTimetables(scheduleLink: station.scheduleLink)
                    { timetables in
                        guard let stationId = station.id else { return }
                        self.busDataService.insertBusTimeTables(for: stationId,
                                                                busTimeTables: timetables,
                                                                lastUpdated: Date())
                    }
                }
                // actually it is not finished by now
                completion()
            }
        }
    }
}
