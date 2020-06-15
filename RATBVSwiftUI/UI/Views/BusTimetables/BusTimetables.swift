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
            Text("Weekdays")
                .tabItem {
                    Text("Weekdays")
            }
            .tag(TimetableTabs.weekdays)
            .navigationBarHidden(false)
            
            Text("Saturday")
                .tabItem {
                    Text("Saturday")
            }
            .tag(TimetableTabs.saturday)
            
            Text("Sunday")
                .tabItem {
                    Text("Sunday")
            }
            .tag(TimetableTabs.sunday)
        }
        .navigationBarTitle(Text(navBarTitle), displayMode: .inline)
    }
}

struct BusTimetables_Previews: PreviewProvider {
    static var previews: some View {
        BusTimetablesView(navBarTitle: "Test Station")
    }
}
