//
//  BusTimetablesViewModel.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import Resolver

enum TimeOfWeekType: String {
    case weekdays = "WeekDays"
    case saturday = "Saturday"
    case sunday = "Sunday"
}

class BusTimetablesViewModel : ObservableObject {
    @Injected private var busRepository: BusRepository
    @Injected private var busWebService: BusWebService
    
    //var busLines = CurrentValueSubject<[BusLine], Never>([])
    @Published var weekdaysTimetable: [BusTimetableViewModel] = []
    @Published var saturdayTimetable: [BusTimetableViewModel] = []
    @Published var sundayTimetable: [BusTimetableViewModel] = []
    @Published var lastUpdateDate: String = "Never"
    
    let busStationId: UUID
    let scheduleLink: String
    
    init(busStationId: UUID, scheduleLink: String) {
        self.busStationId = busStationId
        self.scheduleLink = scheduleLink
    }
    
    func getTimetableByTypeOfWeek(refresh: Bool = false, completion: @escaping () -> (Void)) {
        
        busRepository.getBusTimetables(busStationId: self.busStationId,
                                       scheduleLink: self.scheduleLink,
                                       isForcedRefresh: refresh)
        { busTimetables in
            
            guard let firstBusTimetable = busTimetables.first else
            {
                completion()
                return
            }
            // Set the last updated date
            self.lastUpdateDate = firstBusTimetable.lastUpdateDate ?? "Never"
            
            let sortedBusTimetables = busTimetables.sorted()
            
            self.weekdaysTimetable = sortedBusTimetables
                .filter { $0.timeOfWeek == TimeOfWeekType.weekdays.rawValue }
                .map { BusTimetableViewModel(busTimetable: $0) }
            
            self.saturdayTimetable = sortedBusTimetables
                .filter { $0.timeOfWeek == TimeOfWeekType.saturday.rawValue }
                .map { BusTimetableViewModel(busTimetable: $0) }
            
            self.sundayTimetable = sortedBusTimetables
                .filter { $0.timeOfWeek == TimeOfWeekType.sunday.rawValue }
                .map { BusTimetableViewModel(busTimetable: $0) }
                
            completion()
        }
    }
    
    // Viewmodel class for bus timetable cells
    class BusTimetableViewModel : ObservableObject {
        @Published var id: UUID
        @Published var hour: String
        @Published var minutes: String
        
        init(busTimetable: BusTimetable) {
            self.id = busTimetable.id
            self.hour = busTimetable.hour
            self.minutes = busTimetable.minutes
        }
    }
}
