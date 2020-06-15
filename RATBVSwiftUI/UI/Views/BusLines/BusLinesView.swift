//
//  BusLinesView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

enum TransportTypeTabs: String {
    case bus = "Bus"
    case midibus = "Midibus"
    case trolleybus = "Trolleybus"
}

struct BusLinesView: View {
    @State private var currentTab = TransportTypeTabs.bus
    private let navBarText = "Bus Lines"
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                BusLineListView(startIndex: 0)
                    .tabItem {
                        Image("tab-bus")
                        Text(TransportTypeTabs.bus.rawValue)
                    }
                    .tag(TransportTypeTabs.bus)
                
                BusLineListView(startIndex: 10)
                    .tabItem {
                        Image("tab-midibus")
                            .font(.title)
                        Text(TransportTypeTabs.midibus.rawValue)
                    }
                    .tag(TransportTypeTabs.midibus)
                
                BusLineListView(startIndex: 20)
                    .tabItem {
                        Image("tab-trolleybus")
                            .font(.title)
                        Text(TransportTypeTabs.trolleybus.rawValue)
                    }
                    .tag(TransportTypeTabs.trolleybus)
            }
            .navigationBarTitle(navBarText)
        }
    }
}

struct BusLinesView_Previews: PreviewProvider {
    static var previews: some View {
        BusLinesView()
    }
}
