//
//  BusLineMO+Model.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 10/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

extension BusLineMO {
    func from(busLine: BusLine) {
        self.id = Int32(busLine.id)
        self.name = busLine.name
        self.route = busLine.route
        self.type = busLine.type
        self.linkNormalWay = busLine.linkNormalWay
        self.linkReverseWay = busLine.linkReverseWay
        self.lastUpdateDate = busLine.lastUpdateDate
    }
}
