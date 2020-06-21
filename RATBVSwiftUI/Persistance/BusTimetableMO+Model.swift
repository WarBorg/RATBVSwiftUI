//
//  BusTimetableMO+Model.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

extension BusTimetableMO {
    func from(busTimetable: BusTimetable) {
        self.id = busTimetable.id
        self.hour = busTimetable.hour
        self.minutes = busTimetable.minutes
        self.timeOfWeek = busTimetable.timeOfWeek
        self.lastUpdateDate = busTimetable.lastUpdateDate
    }
}
