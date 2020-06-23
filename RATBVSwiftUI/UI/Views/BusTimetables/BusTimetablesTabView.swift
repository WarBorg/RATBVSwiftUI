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

struct BusTimetablesTabView: View {
    @ObservedObject private(set) var busTimetablesViewModel: BusTimetablesViewModel
    @State private var isBusy = false
    let navBarTitle: String
    
    var body: some View {
        TabView {
            BusTimetableListView(
                isBusy: $isBusy,
                busTimetables: busTimetablesViewModel.weekdaysTimetable,
                onRefresh: { self.busTimetablesViewModel.getTimetableByTypeOfWeek(
                    refresh: true,
                    completion: {
                        self.isBusy = false
                }) },
                lastUpdateDate: busTimetablesViewModel.lastUpdateDate)
                .tabItem {
                    Text(TimetableTabs.weekdays.rawValue)
            }
            .tag(TimetableTabs.weekdays)
            
            BusTimetableListView(
            isBusy: $isBusy,
                busTimetables: busTimetablesViewModel.saturdayTimetable,
                onRefresh: { self.busTimetablesViewModel.getTimetableByTypeOfWeek(
                    refresh: true,
                    completion: {
                        self.isBusy = false
                }) },
                lastUpdateDate: busTimetablesViewModel.lastUpdateDate)
                .tabItem {
                    Text(TimetableTabs.saturday.rawValue)
            }
            .tag(TimetableTabs.saturday)
            
            BusTimetableListView(
            isBusy: $isBusy,
                busTimetables: busTimetablesViewModel.sundayTimetable,
                onRefresh: { self.busTimetablesViewModel.getTimetableByTypeOfWeek(
                    refresh: true,
                    completion: {
                        self.isBusy = false
                }) },
                lastUpdateDate: busTimetablesViewModel.lastUpdateDate)
                .tabItem {
                    Text(TimetableTabs.sunday.rawValue)
            }
            .tag(TimetableTabs.sunday)
        }
        .navigationBarTitle(Text(navBarTitle), displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            self.busTimetablesViewModel.getTimetableByTypeOfWeek(refresh: false, completion: {})
        }
    }
    
    
    
}

//#if DEBUG
//struct BusTimetablesView_Previews: PreviewProvider {
//    static var previews: some View {
//        BusTimetablesTabView(navBarTitle: "Test Station")
//    }
//}
//#endif
