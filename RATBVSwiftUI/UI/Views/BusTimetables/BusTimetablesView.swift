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
    let navBarTitle: String
    
    var body: some View {
        TabView {
            BusTimetableListView()
                .tabItem {
                    Text(TimetableTabs.weekdays.rawValue)
            }
            .tag(TimetableTabs.weekdays)
            
            BusTimetableListView()
                .tabItem {
                    Text(TimetableTabs.saturday.rawValue)
            }
            .tag(TimetableTabs.saturday)
            
            BusTimetableListView()
                .tabItem {
                    Text(TimetableTabs.sunday.rawValue)
            }
            .tag(TimetableTabs.sunday)
        }
        .navigationBarTitle(Text(navBarTitle), displayMode: .inline)
    }
}

struct BusTimetablesView_Previews: PreviewProvider {
    static var previews: some View {
        BusTimetablesView(navBarTitle: "Test Station")
    }
}
