//
//  BusTimetable.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation

struct BusTimetable : Identifiable {
    let id: UUID
    var oid: Int64 = Int64.min
    let hour: String
    let minutes: String
    let timeOfWeek: String
    var lastUpdateDate: String?
    
    init(oid: Int64,
         hour: String,
         minutes: String,
         timeOfWeek: String) {
        self.id = UUID()
        self.oid = oid
        self.hour = hour
        self.minutes = minutes
        self.timeOfWeek = timeOfWeek
        self.lastUpdateDate = "30/09/1985 21:00"
    }
    
    init(mo: BusTimetableMO) {
        self.id = mo.id ?? UUID()
        self.oid = mo.oid
        self.hour = mo.hour ?? ""
        self.minutes = mo.minutes ?? ""
        self.timeOfWeek = mo.timeOfWeek ?? ""
        self.lastUpdateDate = mo.lastUpdateDate ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case hour
        case minutes
        case timeOfWeek
    }
}

extension BusTimetable: Comparable {
    static func < (lhs: BusTimetable, rhs: BusTimetable) -> Bool {
        return lhs.oid < rhs.oid
    }
}

extension BusTimetable: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        hour = try values.decode(String.self, forKey: .hour)
        minutes = try values.decode(String.self, forKey: .minutes)
        timeOfWeek = try values.decode(String.self, forKey: .timeOfWeek)
    }
}
