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
        
        getTimetableByTypeOfWeek()
    }
    
    func getTimetableByTypeOfWeek(refresh: Bool = false) {
        
        busRepository.getBusTimetables(busStationId: self.busStationId,
                                       schedualLink: self.scheduleLink,
                                       isForcedRefresh: refresh) { busTimetables in
//            busWebService.getBusTimetables(scheduleLink: self.scheduleLink) { busTimetables in
                
            guard let firstBusTimetable = busTimetables.first else { return }
            // Set the last updated date
            self.lastUpdateDate = firstBusTimetable.lastUpdateDate ?? "Never"
            
            self.weekdaysTimetable = busTimetables
                .filter { $0.timeOfWeek == TimeOfWeekType.weekdays.rawValue }
                .map { BusTimetableViewModel(busTimetable: $0) }
            
            self.saturdayTimetable = busTimetables
                .filter { $0.timeOfWeek == TimeOfWeekType.saturday.rawValue }
                .map { BusTimetableViewModel(busTimetable: $0) }
            
            self.sundayTimetable = busTimetables
                .filter { $0.timeOfWeek == TimeOfWeekType.sunday.rawValue }
                .map { BusTimetableViewModel(busTimetable: $0) }
            }
    }
    
    // Viewmodel class for bus timetable cells
    class BusTimetableViewModel : ObservableObject {
        @Published var id: UUID
        @Published var hour: String
        @Published var minutes: String
        
        init(busTimetable: BusTimetable) {
            self.id = busTimetable.id ?? UUID()
            self.hour = busTimetable.hour
            self.minutes = busTimetable.minutes
        }
    }
}
