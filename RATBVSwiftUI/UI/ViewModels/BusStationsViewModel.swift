//
//  BusStationsViewModel.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import Alamofire

class BusStationsViewModel : ObservableObject {
    @Published var busStions: [BusStationViewModel] = []
    @Published var lastUpdateDate: String = "Never"
    
    //let busLineId: UUID
    //let linkNormalWay: String
    //let linkReverseWay: String

    init() {
        getBusStationsFromWebAPI()
    }
    
    func getBusStationsFromWebAPI() {
        
        AF
            .request("https://ratbvwebapi.azurewebsites.net/api/busstations/afisaje___5-dus.html")
            .validate()
            .responseDecodable(of: [BusStation].self) { response in
                switch(response.result) {
                    case .success(_):
                        // Unwrap optional [BusStation]? before sending it to the method
                        self.getBusStations(response.value.map({ $0 }) ?? [])
                        // Set the last updated date
                        self.lastUpdateDate = response.value?[0].lastUpdateDate ?? "Never"
                    case .failure(_):
                        break
                    }
        }
    }
    
    func getBusStations(_ busStations: [BusStation]) {
        //var direction = "Normal"
        
        self.busStions = busStations
            //.filter({ $0.  == TransportTypeTabs.bus.rawValue })
            .map { BusStationViewModel(busStation: $0) }
    }
    
    // Viewmodel class for bus station cells
    class BusStationViewModel : ObservableObject {
        @Published var id: UUID
        @Published var name: String
        
        init(busStation: BusStation) {
            self.id = busStation.id
            self.name = busStation.name
        }
    }
}
