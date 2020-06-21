//
//  BusLine.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 18/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation

struct BusLine : Identifiable, Decodable {
    let id: Int
    let name: String
    let route: String
    let type: String
    let linkNormalWay: String
    let linkReverseWay: String
    let lastUpdateDate = "30/09/1985 21:00"
}
