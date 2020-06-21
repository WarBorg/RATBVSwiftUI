//
//  BusLinesView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusLinesView: View {
    @ObservedObject private var busLineViewModel = BusLinesViewModel()
    @State private var currentTab = TransportTypeTabs.bus
    private let navBarText = "Bus Lines"
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                BusLineListView(
                    busLines: busLineViewModel.busLines,
                    lastUpdateDate: busLineViewModel.lastUpdateDate)
                    .tabItem {
                        Image("tab-bus")
                        Text(TransportTypeTabs.bus.rawValue)
                    }
                    .tag(TransportTypeTabs.bus)
                
                BusLineListView(
                busLines: busLineViewModel.midibusLines,
                lastUpdateDate: busLineViewModel.lastUpdateDate)
                    .tabItem {
                        Image("tab-midibus")
                            .font(.title)
                        Text(TransportTypeTabs.midibus.rawValue)
                    }
                    .tag(TransportTypeTabs.midibus)
                
                BusLineListView(
                busLines: busLineViewModel.trolleyBusLines,
                lastUpdateDate: busLineViewModel.lastUpdateDate)
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
