//
//  ContentView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 03/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

enum TransportTypeTabs: String {
    case bus = "Bus"
    case midibus = "Midibus"
    case trolleybus = "Trolleybus"
}

struct ContentView: View {
    @State private var currentTab = TransportTypeTabs.bus
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                BusLineListView(startIndex: 0)
                    .tabItem {
                        Image(systemName: "star")
                            .font(.title)
                        Text(TransportTypeTabs.bus.rawValue)
                    }
                    .tag(TransportTypeTabs.bus)
                
                BusLineListView(startIndex: 10)
                    .tabItem {
                        Image(systemName: "heart")
                            .font(.title)
                        Text(TransportTypeTabs.midibus.rawValue)
                    }
                    .tag(TransportTypeTabs.midibus)
                
                BusLineListView(startIndex: 20)
                    .tabItem {
                        Image(systemName: "cloud")
                            .font(.title)
                        Text(TransportTypeTabs.trolleybus.rawValue)
                    }
                    .tag(TransportTypeTabs.trolleybus)
                .navigationBarTitle("\(TransportTypeTabs.trolleybus.rawValue) Lines")
            }
            .navigationBarTitle("Bus Lines")
        }
    }
}















#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
