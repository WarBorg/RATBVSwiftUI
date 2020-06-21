//
//  BusTimetablesView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

enum TimetableTabs: String {
    case weekdays = "Weekdays"
    case saturday = "Saturday"
    case sunday = "Sunday"
}

struct BusTimetablesView: View {
    @ObservedObject private var busTimetablesViewModel = BusTimetablesViewModel()
    let navBarTitle: String
    
    var body: some View {
        TabView {
            BusTimetableListView(
                busTimetables: busTimetablesViewModel.weekdaysTimetable,
                lastUpdateDate: busTimetablesViewModel.lastUpdateDate)
                .tabItem {
                    Text(TimetableTabs.weekdays.rawValue)
            }
            .tag(TimetableTabs.weekdays)
            
            BusTimetableListView(
                busTimetables: busTimetablesViewModel.saturdayTimetable,
                lastUpdateDate: busTimetablesViewModel.lastUpdateDate)
                .tabItem {
                    Text(TimetableTabs.saturday.rawValue)
            }
            .tag(TimetableTabs.saturday)
            
            BusTimetableListView(
                busTimetables: busTimetablesViewModel.sundayTimetable,
                lastUpdateDate: busTimetablesViewModel.lastUpdateDate)
                .tabItem {
                    Text(TimetableTabs.sunday.rawValue)
            }
            .tag(TimetableTabs.sunday)
        }
        .navigationBarTitle(Text(navBarTitle), displayMode: .inline)
    }
}

#if DEBUG
struct BusTimetablesView_Previews: PreviewProvider {
    static var previews: some View {
        BusTimetablesView(navBarTitle: "Test Station")
    }
}
#endif
