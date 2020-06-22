//
//  BusLine.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 18/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation

struct BusLine : Identifiable, Decodable, Comparable {

    let id: Int
    let name: String
    let route: String
    let type: String
    let linkNormalWay: String
    let linkReverseWay: String
    let lastUpdateDate: String? // = "30/09/1985 21:00"
    
    init(id: Int,
         name: String,
         route: String,
         type: String,
         linkNormalWay: String,
         linkReverseWay: String) {
        self.id = id
        self.name = name
        self.route = route
        self.type = type
        self.linkNormalWay = linkNormalWay
        self.linkReverseWay = linkReverseWay
        self.lastUpdateDate = "30/09/1985 21:00"
    }

    init(mo: BusLineMO) {
        self.id = Int(mo.id)
        self.name = mo.name ?? ""
        self.route = mo.route ?? ""
        self.type = mo.type ?? ""
        self.linkNormalWay = mo.linkNormalWay ?? ""
        self.linkReverseWay = mo.linkReverseWay ?? ""
        self.lastUpdateDate = mo.lastUpdateDate ?? ""
    }
    
    static func < (lhs: BusLine, rhs: BusLine) -> Bool {
        return lhs.id < rhs.id
    }
}
