//
//  BusLinesView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI
import Resolver

struct BusLinesView: View, Resolving {
    @InjectedObject private var busLinesViewModel: BusLinesViewModel
    @State private var currentTab = TransportTypeTabs.bus
    private let navBarText = "Bus Lines"
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                BusLineListView(
                    busLines: busLinesViewModel.busLines,
                    lastUpdateDate: busLinesViewModel.lastUpdateDate)
                    .tabItem {
                        Image("tab-bus")
                        Text(TransportTypeTabs.bus.rawValue)
                    }
                    .tag(TransportTypeTabs.bus)
                
                BusLineListView(
                busLines: busLinesViewModel.midibusLines,
                lastUpdateDate: busLinesViewModel.lastUpdateDate)
                    .tabItem {
                        Image("tab-midibus")
                            .font(.title)
                        Text(TransportTypeTabs.midibus.rawValue)
                    }
                    .tag(TransportTypeTabs.midibus)
                
                BusLineListView(
                busLines: busLinesViewModel.trolleyBusLines,
                lastUpdateDate: busLinesViewModel.lastUpdateDate)
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

#if DEBUG
struct BusLinesView_Previews: PreviewProvider {
    static var previews: some View {
        BusLinesView()
    }
}
#endif
