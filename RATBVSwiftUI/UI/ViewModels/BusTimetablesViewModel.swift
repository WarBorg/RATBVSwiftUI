//
//  BusTimetablesViewModel.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import Alamofire

enum TimeOfWeekType: String {
    case weekdays = "WeekDays"
    case saturday = "Saturday"
    case sunday = "Sunday"
}

class BusTimetablesViewModel : ObservableObject {

    //var busLines = CurrentValueSubject<[BusLine], Never>([])
    @Published var weekdaysTimetable: [BusTimetableViewModel] = []
    @Published var saturdayTimetable: [BusTimetableViewModel] = []
    @Published var sundayTimetable: [BusTimetableViewModel] = []
    @Published var lastUpdateDate: String = "Never"

    init() {
        getBusTimetablesFromWebAPI()
    }
    
    func getBusTimetablesFromWebAPI() {
        AF
        .request("https://ratbvwebapi.azurewebsites.net/api/bustimetables/6-dus___line_6_6_cl2_ro.html")
        .validate()
            .responseDecodable(of: [BusTimetable].self) { response in
                switch(response.result) {
                    case .success(_):
                        // Unwrap optional [BusTimetable]? before sending it to the method
                        self.getTimetableByTypeOfWeek(response.value.map({ $0 }) ?? [])
                        // Set the last updated date
                        self.lastUpdateDate = response.value?[0].lastUpdateDate ?? "Never"
                    case .failure(_):
                        break
                    }
        }
    }
    
    func getTimetableByTypeOfWeek(_ busTimetables: [BusTimetable]) {
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
