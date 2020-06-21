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
    func insertBusLines(busLines: [BusLine])
    func clearBusLines()
    
    func countBusStationsByBusLineIdAndDirection(busLineId: Int, direction: String) -> Int
    func getBusStationsByBusLineIdAndDirection(busLineId: Int, direction: String) -> [BusStation]
    func insertBusStations(for busLineId: Int, busStations: [BusStation])
    func clearBusStationsByBusLineId(for busLineId: Int)
    func clearBusStationsByBusLineIdAndDirection(for busLineId: Int, direction: String)
    
    func countBusTimeTableByBusStationId(busStationId: UUID) -> Int
    func getBusTimeTableByBusStationId(busStationId: UUID) -> [BusTimetable]
    func insertBusTimeTables(for busStationId: UUID, busTimeTables: [BusTimetable])
    func clearBusTimetablesByBusStationId(for busStationId: UUID)
}

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

    func insertBusLines(busLines: [BusLine]) {
        for line in busLines {
            BusLineMO(context: self.manageObjectContext)
                .from(busLine: line)
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
        do {
            return
                try self.manageObjectContext.fetch(self.fetchRequest(forBusLine: busLineId))
                    .first?
                    .stations?
                    .filtered(using: NSPredicate(format: "direction = %@", direction))
                    .count ?? 0
        } catch {
            print("Failed getting count for bus stations by bus line and direction: \(error.localizedDescription)")
        }
        return 0
    }

    func getBusStationsByBusLineIdAndDirection(busLineId: Int, direction: String) -> [BusStation] {
        do {
            let stations = try self.manageObjectContext.fetch(self.fetchRequest(forBusLine: busLineId))
                .first?
                .stations?
                .filtered(using: NSPredicate(format: "direction = %@", direction))
            return stations?
                .map( { BusStation(mo: $0 as! BusStationMO) } ) ?? []
        } catch {
            print("Failed getting bus stations by bus line and direction: \(error.localizedDescription)")
        }
        return []
    }

    func insertBusStations(for busLineId: Int, busStations: [BusStation]) {
        for station in busStations {
            BusStationMO(context: self.manageObjectContext)
                .from(busStation: station)
        }
        do {
            try self.manageObjectContext.save()
        } catch {
            print("Failed saving bus stations: \(error.localizedDescription)")
        }
    }

    func clearBusStationsByBusLineId(for busLineId: Int) {
        do {
            try self.manageObjectContext
                .fetch(self.fetchRequest(forBusLine: busLineId))
                .first?
                .stations = nil
            try self.manageObjectContext.save()
        } catch {
            print("Failed claring bus stations by bus line id: \(error.localizedDescription)")
        }
    }
    
    func clearBusStationsByBusLineIdAndDirection(for busLineId: Int, direction: String) {
        do {
            guard let line = try self.manageObjectContext.fetch(self.fetchRequest(forBusLine: busLineId)).first else { return }
            guard let stations = line.stations?.filtered(using: NSPredicate(format: "direction = %@", direction)) as NSSet? else { return }
            line.removeFromStations(stations)
            try self.manageObjectContext.save()
        } catch {
            print("Failed claring bus stations by bus line and direction: \(error.localizedDescription)")
        }
    }
    
    // MARK: Time Table

    func countBusTimeTableByBusStationId(busStationId: UUID) -> Int {
        do {
            return
                try self.manageObjectContext.fetch(self.fetchRequest(forBusStation: busStationId))
                    .first?
                    .timetables?
                    .count ?? 0
        } catch {
            print("Failed getting count for bus timetable by bus station id: \(error.localizedDescription)")
        }
        return 0
    }

    func getBusTimeTableByBusStationId(busStationId: UUID) -> [BusTimetable] {
        do {
            let timetables = try self.manageObjectContext.fetch(self.fetchRequest(forBusStation: busStationId))
                .first?
                .timetables
            return timetables?
                .map( { BusTimetable(mo: $0 as! BusTimetableMO) } ) ?? []
        } catch {
            print("Failed getting bus timetable by station id: \(error.localizedDescription)")
        }
        return []
    }

    func insertBusTimeTables(for busStationId: UUID, busTimeTables: [BusTimetable]) {
        for timeTable in busTimeTables {
            BusTimetableMO(context: self.manageObjectContext)
                .from(busTimetable: timeTable)
        }
        do {
            try self.manageObjectContext.save()
        } catch {
            print("Failed saving bus timetables: \(error.localizedDescription)")
        }
    }

    func clearBusTimetablesByBusStationId(for busStationId: UUID) {
        do {
            try self.manageObjectContext
                .fetch(self.fetchRequest(forBusStation: busStationId))
                .first?
                .timetables = nil
            try self.manageObjectContext.save()
        } catch {
            print("Failed clearing bus timetables: \(error.localizedDescription)")
        }
    }
    
    // MARK: Fetch Request Helpers

    internal func fetchRequest(forBusLine id: Int) -> NSFetchRequest<BusLineMO> {
        let request: NSFetchRequest<BusLineMO> = BusLineMO.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        request.fetchLimit = 1
        return request
    }

    internal func fetchRequest(forBusStation id: UUID) -> NSFetchRequest<BusStationMO> {
        let request: NSFetchRequest<BusStationMO> = BusStationMO.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        request.fetchLimit = 1
        return request
    }
}
