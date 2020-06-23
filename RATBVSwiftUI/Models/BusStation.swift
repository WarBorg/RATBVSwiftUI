//
//  BusStation.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation

struct BusStation : Identifiable {
    let id: UUID
    var oid: Int64 = Int64.min
    let name: String
    var direction: String?
    let scheduleLink: String
    var lastUpdateDate: String?

    init(mo: BusStationMO) {
        self.id = mo.id ?? UUID()
        self.oid = mo.oid
        self.name = mo.name ?? ""
        self.direction = mo.direction ?? ""
        self.scheduleLink = mo.scheduleLink ?? ""
        self.lastUpdateDate = mo.lastUpdateDate ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case direction
        case scheduleLink
    }
}

extension BusStation: Comparable {
    static func < (lhs: BusStation, rhs: BusStation) -> Bool {
        return lhs.oid < rhs.oid
    }
}

extension BusStation: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        name = try values.decode(String.self, forKey: .name)
        direction = try values.decodeIfPresent(String.self, forKey: .direction)
        scheduleLink = try values.decode(String.self, forKey: .scheduleLink)
    }
}
