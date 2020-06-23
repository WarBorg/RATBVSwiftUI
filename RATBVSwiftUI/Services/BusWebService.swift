//
//  BusWebService.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 10/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import Alamofire

protocol BusWebService {
    func getBusLines(completion: @escaping ([BusLine]) -> Void)
    func getBusStations(directionLink: String, completion: @escaping ([BusStation]) -> Void)
    func getBusTimetables(scheduleLink: String, completion: @escaping ([BusTimetable]) -> Void)
}

class AlamofireBusWebService : BusWebService{

    let busWebAPIBaseAddress = "https://ratbvwebapi.azurewebsites.net/api/"
    
    func getBusLines(completion: @escaping ([BusLine]) -> Void) {
        
        AF
            .request("\(busWebAPIBaseAddress)buslines/")
            .validate()
            .responseDecodable(of: [BusLine].self) { response in
                switch(response.result) {
                    case .success(_):
                        // Unwrap optional [BusLine]? before sending it to the method
                        completion(response.value.map({ $0 }) ?? [])
                        
                    case .failure(_):
                        completion([])
                    }
        }
    }
    
    func getBusStations(directionLink: String, completion: @escaping ([BusStation]) -> Void) {
        
        let requestAddress = "\(busWebAPIBaseAddress)busstations/\(directionLink)"
        
        AF
            .request(requestAddress)
            .validate()
            .responseDecodable(of: [BusStation].self) { response in
                switch(response.result) {
                    case .success(_):
                        // Unwrap optional [BusStation]? before sending it to the method
                        completion(response.value.map { $0 } ?? [])
                        
                    case .failure(_):
                        completion([])
                    }
        }
    }
    
    func getBusTimetables(scheduleLink: String, completion: @escaping ([BusTimetable]) -> Void) {
        
        let requestAddress = "\(busWebAPIBaseAddress)bustimetables/\(scheduleLink)"
        
        AF
        .request(requestAddress)
        .validate()
            .responseDecodable(of: [BusTimetable].self) { response in
                switch(response.result) {
                    case .success(_):
                        // Unwrap optional [BusTimetable]? before sending it to the method
                        completion(response.value.map({ $0 }) ?? [])
                        
                    case .failure(_):
                        completion([])
                    }
        }
    }
}
