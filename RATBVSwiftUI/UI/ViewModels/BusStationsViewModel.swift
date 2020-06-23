//
//  BusStationsViewModel.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import Resolver

enum RouteDirections: String {
    case normal = "Normal"
    case reverse = "Reverse"
}

class BusStationsViewModel : ObservableObject {
    @Injected private var busRepository: BusRepository
    
    @Published var busStations: [BusStationViewModel] = []
    @Published var lastUpdateDate: String = "Never"
    @Published var direction: RouteDirections = RouteDirections.normal
    
    let busLineId: Int
    let linkNormalWay: String
    let linkReverseWay: String
    
    private var directionLink = ""
    
    init(busLineId: Int, linkNormalWay: String, linkReverseWay: String) {
        self.busLineId = busLineId
        self.linkNormalWay = linkNormalWay
        self.linkReverseWay = linkReverseWay
    }
    
    func getBusStations(refresh: Bool, shouldReverseWay: Bool, completion: @escaping () -> (Void)) {
        // If there is a forced user refresh we want to keep the same Direction
        if (!refresh)
        {
            // Initial view of the stations list should be normal way
            if (!shouldReverseWay)
            {
                directionLink = direction == RouteDirections.reverse ? self.linkReverseWay : self.linkNormalWay
            }
            else if (shouldReverseWay && direction == RouteDirections.normal)
            {
                direction = RouteDirections.reverse
                directionLink = self.linkReverseWay
            }
            else if (shouldReverseWay && direction == RouteDirections.reverse)
            {
                direction = RouteDirections.normal
                directionLink = self.linkNormalWay
            }
        }
        
        // If there is a second try to load the data just return (NOT WORKING)
        if (!refresh && !shouldReverseWay && !self.busStations.isEmpty)
        {
            completion()
            return;
        }
        
        busRepository.getBusStations(busLineId: self.busLineId,
                                     directionLink:  self.linkNormalWay,
                                     direction: self.directionLink,
                                     isForcedRefresh: refresh)
        { busStations in
            guard let firstBusStation = busStations.first else { return }
            // Set the last updated date
            self.lastUpdateDate = firstBusStation.lastUpdateDate ?? "Never"
            
            if self.direction == RouteDirections.reverse {
                self.busStations = busStations
                    .sorted()
                    .reversed()
                    .map { BusStationViewModel(busStation: $0) }
            } else {
                self.busStations = busStations
                    .sorted()
                    .map { BusStationViewModel(busStation: $0) }
            }
            completion()
        }
    }
    
    func showReverseTripStations() {
        getBusStations(refresh: false, shouldReverseWay: true, completion: {})
    }
    
    func downloadAllStationTimetables() {
        busRepository.downloadAllStationsTimetables(
            busLineId: busLineId,
            normalDirectionLink: linkNormalWay,
            reverseDirectionLink: linkReverseWay) {
                print("Download complete for all bus stations time tables")
        }
    }
    
    // Viewmodel class for bus station cells
    class BusStationViewModel : ObservableObject {
        @Published var id: UUID
        @Published var name: String
        let scheduleLink: String
        
        init(busStation: BusStation) {
            self.id = busStation.id
            self.name = busStation.name
            self.scheduleLink = busStation.scheduleLink
        }
    }
}
