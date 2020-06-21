//
//  BusStationsViewModel.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import Resolver

class BusStationsViewModel : ObservableObject {
    @Injected private var busWebService: BusWebService
    
    @Published var busStations: [BusStationViewModel] = []
    @Published var lastUpdateDate: String = "Never"
    
    let busLineId: Int
    let linkNormalWay: String
    let linkReverseWay: String
    
    private var isRefresh = false

    init(busLineId: Int, linkNormalWay: String, linkReverseWay: String) {
        self.busLineId = busLineId
        self.linkNormalWay = linkNormalWay
        self.linkReverseWay = linkReverseWay
        
        getBusStations()
    }
    
    func getBusStations() {
        // If there is a forced user refresh we want to keep the same Direction
        if (!isRefresh)
        {
            // Initial view of the stations list should be normal way
//            if (!shouldReverseWay)
//            {
//                Direction = RouteDirections.Normal;
//
//                _directionLink = _busLine.LinkNormalWay;
//            }
//            else if (shouldReverseWay && Direction == RouteDirections.Normal)
//            {
//                Direction = RouteDirections.Reverse;
//
//                _directionLink = _busLine.LinkReverseWay;
//            }
//            else if (shouldReverseWay && Direction == RouteDirections.Reverse)
//            {
//                Direction = RouteDirections.Normal;
//
//                _directionLink = _busLine.LinkNormalWay;
//            }
        }
        
        busWebService.getBusStations(directionLink: self.linkNormalWay) { busStations in
            
            if (busStations.isEmpty) {
                self.lastUpdateDate = "Never"
                return
            }
                // Set the last updated date
                self.lastUpdateDate = busStations[0].lastUpdateDate ?? "Never"
                
                self.busStations = busStations
                    .map { BusStationViewModel(busStation: $0) }
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
