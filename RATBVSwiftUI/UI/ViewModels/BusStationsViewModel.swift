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
    @Published var direction = RouteDirections.normal
    
    let busLineId: Int
    let linkNormalWay: String
    let linkReverseWay: String
    
    private var directionLink = ""

    init(busLineId: Int, linkNormalWay: String, linkReverseWay: String) {
        self.busLineId = busLineId
        self.linkNormalWay = linkNormalWay
        self.linkReverseWay = linkReverseWay
        
        getBusStations(refresh: false, shouldReverseWay: false)
    }
    
    func getBusStations(refresh: Bool, shouldReverseWay: Bool) {
        // If there is a forced user refresh we want to keep the same Direction
        if (!refresh)
        {
            // Initial view of the stations list should be normal way
            if (!shouldReverseWay)
            {
                direction = RouteDirections.normal;
                directionLink = self.linkNormalWay;
            }
            else if (shouldReverseWay && direction == RouteDirections.normal)
            {
                direction = RouteDirections.reverse;
                directionLink = self.linkReverseWay;
            }
            else if (shouldReverseWay && direction == RouteDirections.reverse)
            {
                direction = RouteDirections.normal;
                directionLink = self.linkNormalWay;
            }
        }
        
        // If there is a second try to load the data just return (NOT WORKING)
        if (!refresh && !shouldReverseWay && !self.busStations.isEmpty)
        {
            return;
        }
        
        busRepository.getBusStations(busLineId: self.busLineId,
                                 directionLink:  self.linkNormalWay,
                                 direction: self.directionLink,
                                 isForcedRefresh: refresh) { busStations in
            
            guard let firstBusStation = busStations.first else { return }
            // Set the last updated date
            self.lastUpdateDate = firstBusStation.lastUpdateDate ?? "Never"
                
            self.busStations = busStations
                .map { BusStationViewModel(busStation: $0) }
        }
    }
    
    func showReverseTripStations() {
        getBusStations(refresh: false, shouldReverseWay: true);
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
            self.id = busStation.id ?? UUID()
            self.name = busStation.name
            self.scheduleLink = busStation.scheduleLink
        }
    }
}
