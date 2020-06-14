//
//  BusTimetableListView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

enum TimetableTabs {
    case weekdays, saturday, sunday
}

struct BusTimetableListView: View {
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
    }
}

struct BusTimetableListView_Previews: PreviewProvider {
    static var previews: some View {
        BusTimetableListView()
    }
}
