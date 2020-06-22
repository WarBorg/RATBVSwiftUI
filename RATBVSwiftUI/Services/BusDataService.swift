//
//  BusDataService.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 10/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import CoreData

protocol BusDataService {
    func countBusLines() -> Int
    func getBusLines() -> [BusLine]
    func insertBusLines(busLines: [BusLine], lastUpdated: Date)
    func clearBusLines()
    
    func countBusStationsByBusLineIdAndDirection(busLineId: Int, direction: String) -> Int
    func getBusStationsByBusLineIdAndDirection(busLineId: Int, direction: String) -> [BusStation]
    func insertBusStations(for busLineId: Int, busStations: [BusStation], lastUpdated: Date)
    func clearBusStationsByBusLineId(for busLineId: Int)
    func clearBusStationsByBusLineIdAndDirection(for busLineId: Int, direction: String)
    
    func countBusTimeTableByBusStationId(busStationId: UUID) -> Int
    func getBusTimeTableByBusStationId(busStationId: UUID) -> [BusTimetable]
    func insertBusTimeTables(for busStationId: UUID, busTimeTables: [BusTimetable], lastUpdated: Date)
    func clearBusTimetablesByBusStationId(for busStationId: UUID)
}

// MARK: CoreDataBusDataService
class CoreDataBusDataService: BusDataService {
    
    let manageObjectContext: NSManagedObjectContext
    
    init(manageObjectContext: NSManagedObjectContext) {
        self.manageObjectContext = manageObjectContext
    }
    
    // MARK: Lines
    
    func countBusLines() -> Int {
        let request: NSFetchRequest<BusLineMO> = BusLineMO.fetchRequest()
        do {
            return
                try self.manageObjectContext.count(for: request)
        } catch {
            print("Failed getting bus lines count: \(error.localizedDescription)")
        }
        return 0
    }
    
    func getBusLines() -> [BusLine] {
        let request: NSFetchRequest<BusLineMO> = BusLineMO.fetchRequest()
        do {
            return
                try self.manageObjectContext
                    .fetch(request)
                    .map( { BusLine(mo: $0) } )
        } catch {
            print("Failed getting bus lines: \(error.localizedDescription)")
        }
        return []
    }
    
    func insertBusLines(busLines: [BusLine], lastUpdated: Date) {
        for line in busLines {
            let mo = BusLineMO(context: self.manageObjectContext)
            mo.from(busLine: line)
            mo.lastUpdateDate = lastUpdated.formatted()
        }
        do {
            try self.manageObjectContext.save()
        } catch {
            print("Failed saving bus lines: \(error.localizedDescription)")
        }
    }
    
    func clearBusLines() {
        let request: NSFetchRequest<NSFetchRequestResult> = BusLineMO.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.manageObjectContext.execute(deleteRequest)
        } catch {
            print("Failed clearing bus lines: \(error.localizedDescription)")
        }
    }
    
    // MARK: Stations
    
    func countBusStationsByBusLineIdAndDirection(busLineId: Int, direction: String) -> Int {
        guard let line = self.busLine(for: busLineId) else { return 0 }
        guard let stations = line.stations else { return 0 }
        return stations
            .filtered(using: NSPredicate(format: "direction = %@ || direction == nil", direction))
            .count
    }
    
    func getBusStationsByBusLineIdAndDirection(busLineId: Int, direction: String) -> [BusStation] {
        guard let line = self.busLine(for: busLineId) else { return [] }
        guard let stations = line.stations else { return [] }
        return stations
            .filtered(using: NSPredicate(format: "direction = %@ || direction == nil", direction))
            .map( { BusStation(mo: $0 as! BusStationMO) } )
    }
    
    func insertBusStations(for busLineId: Int, busStations: [BusStation], lastUpdated: Date) {
        guard let busLine = self.busLine(for: busLineId) else { return }
        
        for station in busStations {
            let mo = BusStationMO(context: self.manageObjectContext)
            mo.from(busStation: station)
            mo.lastUpdateDate = lastUpdated.formatted()
            busLine.addToStations(mo)
        }
        do {
            try self.manageObjectContext.save()
        } catch {
            print("Failed saving bus stations: \(error.localizedDescription)")
        }
    }
    
    func clearBusStationsByBusLineId(for busLineId: Int) {
        do {
            self.busLine(for: busLineId)?.stations  = nil
            try self.manageObjectContext.save()
        } catch {
            print("Failed clearing bus stations by bus line id: \(error.localizedDescription)")
        }
    }
    
    func clearBusStationsByBusLineIdAndDirection(for busLineId: Int, direction: String) {
        do {
            guard let line = self.busLine(for: busLineId) else { return }
            guard let stations = line.stations?.filtered(using: NSPredicate(format: "direction = %@", direction)) as NSSet? else { return }
            line.removeFromStations(stations)
            try self.manageObjectContext.save()
        } catch {
            print("Failed clearing bus stations by bus line and direction: \(error.localizedDescription)")
        }
    }
    
    // MARK: Time Table
    
    func countBusTimeTableByBusStationId(busStationId: UUID) -> Int {
        return self.busStation(for: busStationId)?.timetables?.count ?? 0
    }
    
    func getBusTimeTableByBusStationId(busStationId: UUID) -> [BusTimetable] {
        return self.busStation(for: busStationId)?
            .timetables?
            .map( { BusTimetable(mo: $0 as! BusTimetableMO) } ) ?? []
    }
    
    func insertBusTimeTables(for busStationId: UUID, busTimeTables: [BusTimetable], lastUpdated: Date) {
        guard let busStation = self.busStation(for: busStationId) else { return }
        
        for timeTable in busTimeTables {
            let mo = BusTimetableMO(context: self.manageObjectContext)
            mo.from(busTimetable: timeTable)
            mo.lastUpdateDate = lastUpdated.formatted()
            mo.station = busStation
        }
        
        do {
            try self.manageObjectContext.save()
        } catch {
            print("Failed saving bus timetables: \(error.localizedDescription)")
        }
    }
    
    func clearBusTimetablesByBusStationId(for busStationId: UUID) {
        do {
            self.busStation(for: busStationId)?.timetables = nil
            try self.manageObjectContext.save()
        } catch {
            print("Failed clearing bus timetables: \(error.localizedDescription)")
        }
    }
    
    // MARK: Fetch Request Helpers
    internal func busLine(for id: Int) -> BusLineMO? {
        do {
            return try self.manageObjectContext
                .fetch(self.fetchRequest(forBusLine: id))
                .first
        } catch {
            print("Failed fetching bus line \(id): \(error.localizedDescription)")
        }
        return nil
    }
    
    internal func busStation(for id: UUID) -> BusStationMO? {
        do {
            return try self.manageObjectContext
                .fetch(self.fetchRequest(forBusStation: id))
                .first
        } catch {
            print("Failed fetching bus station \(id): \(error.localizedDescription)")
        }
        return nil
    }
    
    internal func fetchRequest(forBusLine id: Int) -> NSFetchRequest<BusLineMO> {
        let request: NSFetchRequest<BusLineMO> = BusLineMO.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        request.relationshipKeyPathsForPrefetching = ["stations"]
        return request
    }
    
    internal func fetchRequest(forBusStation id: UUID) -> NSFetchRequest<BusStationMO> {
        let request: NSFetchRequest<BusStationMO> = BusStationMO.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        request.relationshipKeyPathsForPrefetching = ["timetables"]
        return request
    }
}
