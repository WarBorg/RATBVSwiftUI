//
//  BusLinesViewModel.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 18/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import Alamofire
import Combine

enum TransportTypeTabs: String {
    case bus = "Bus"
    case midibus = "Midibus"
    case trolleybus = "Trolleybus"
}

class BusLinesViewModel : ObservableObject {
    
    //var busLines = CurrentValueSubject<[BusLine], Never>([])
    @Published var busLines: [BusLineViewModel] = []
    @Published var midibusLines: [BusLineViewModel] = []
    @Published var trolleyBusLines: [BusLineViewModel] = []
    @Published var lastUpdateDate: String = "Never"
    
    init() {
        getBusLinesFromWebAPI()
    }
    
    func getBusLinesFromWebAPI() {
        AF
        .request("http://ratbvwebapi.azurewebsites.net/api/buslines/")
        .validate()
            .responseDecodable(of: [BusLine].self) { response in
                switch(response.result) {
                    case .success(_):
                        // Unwrap optional [BusLine]? before sending it to the method
                        self.getBusLinesByType(response.value.map({ $0 }) ?? [])
                        // Set the last updated date
                        self.lastUpdateDate = response.value?[0].lastUpdateDate ?? "Never"
                    case .failure(_):
                        break
                    }
        }
    }
    
    func getBusLinesByType(_ busLines: [BusLine]) {
        self.busLines = busLines
            .filter({ $0.type == TransportTypeTabs.bus.rawValue })
            .map({
                BusLineViewModel(id: $0.id, name: $0.name, route: $0.route)
            })
        
        self.midibusLines = busLines
        .filter({ $0.type == TransportTypeTabs.midibus.rawValue })
        .map({
            BusLineViewModel(id: $0.id, name: $0.name, route: $0.route)
        })
        
        self.trolleyBusLines = busLines
        .filter({ $0.type == TransportTypeTabs.trolleybus.rawValue })
        .map({
            BusLineViewModel(id: $0.id, name: $0.name, route: $0.route)
        })
    }
    
    class BusLineViewModel : ObservableObject {
        @Published var id: UUID
        @Published var name: String
        @Published var route: String
        
        init(id: UUID, name: String, route: String) {
            self.id = id
            self.name = name
            self.route = route
        }
    }
}