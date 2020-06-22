//
//  BusLinesViewModel.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 18/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import Combine
import Resolver

enum TransportTypeTabs: String {
    case bus = "Bus"
    case midibus = "Midibus"
    case trolleybus = "Trolleybus"
}

class BusLinesViewModel : ObservableObject {
    @Injected private var busRepository: BusRepository
    
    //var busLines = CurrentValueSubject<[BusLine], Never>([])
    @Published var busLines: [BusLineViewModel] = []
    @Published var midibusLines: [BusLineViewModel] = []
    @Published var trolleyBusLines: [BusLineViewModel] = []
    @Published var lastUpdateDate: String = "Never"
    @Published var isBusy: Bool = false
    
    init() {
        getBusLinesByType(refresh: false)
    }
    
    func getBusLinesByType(refresh: Bool = false) {
        
        busRepository.getBusLines(isForcedRefresh: refresh)  { busLines in

            guard let firstBusLine = busLines.first else { return }
            self.lastUpdateDate = firstBusLine.lastUpdateDate ?? "Never"
            let sortedBusLines = busLines.sorted()
            
            self.busLines = sortedBusLines
                .filter { $0.type == TransportTypeTabs.bus.rawValue }
                .map { BusLineViewModel(busLine: $0) }
            
            self.midibusLines = busLines
                .filter { $0.type == TransportTypeTabs.midibus.rawValue }
                .map { BusLineViewModel(busLine: $0) }
            
            self.trolleyBusLines = busLines
                .filter { $0.type == TransportTypeTabs.trolleybus.rawValue }
                .map { BusLineViewModel(busLine: $0) }
        }
        
        self.isBusy = false
    }
    
    // Viewmodel class for bus line cells
    class BusLineViewModel : ObservableObject {
        @Published var id: Int
        @Published var name: String
        @Published var route: String
        let linkNormalWay: String
        let linkReverseWay: String
        
        init(busLine: BusLine) {
            self.id = busLine.id
            self.name = busLine.name
            self.route = busLine.route
            self.linkNormalWay = busLine.linkNormalWay
            self.linkReverseWay = busLine.linkReverseWay
        }
    }
}
