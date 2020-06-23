//
//  BusLinesView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI
import Resolver

struct BusLinesTabView: View, Resolving {
    @InjectedObject private var busLinesViewModel: BusLinesViewModel
    @State private var currentTab = TransportTypeTabs.bus
    @State private var isBusy = false
    private let navBarText = "Bus Lines"
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                BusLineListView(isBusy: $isBusy,
                    busLines: busLinesViewModel.busLines,
                    onRefresh: { self.busLinesViewModel.getBusLinesByType(
                        refresh: true,
                        completion: {
                            self.isBusy = false
                    }) },
                    lastUpdateDate: busLinesViewModel.lastUpdateDate)
                    .tabItem {
                        Image("tab-bus")
                        Text(TransportTypeTabs.bus.rawValue)
                }
                .tag(TransportTypeTabs.bus)
                
                BusLineListView(
                    isBusy: $isBusy,
                    busLines: busLinesViewModel.midibusLines,
                    onRefresh: { self.busLinesViewModel.getBusLinesByType(
                        refresh: true,
                        completion: {
                            self.isBusy = false
                    }) },
                    lastUpdateDate: busLinesViewModel.lastUpdateDate)
                    .tabItem {
                        Image("tab-midibus")
                            .font(.title)
                        Text(TransportTypeTabs.midibus.rawValue)
                }
                .tag(TransportTypeTabs.midibus)
                
                BusLineListView(
                    isBusy: $isBusy,
                    busLines: busLinesViewModel.trolleyBusLines,
                    onRefresh: { self.busLinesViewModel.getBusLinesByType(
                        refresh: true,
                        completion: {
                            self.isBusy = false
                    }) },
                    lastUpdateDate: busLinesViewModel.lastUpdateDate)
                    .tabItem {
                        Image("tab-trolleybus")
                            .font(.title)
                        Text(TransportTypeTabs.trolleybus.rawValue)
                }
                .tag(TransportTypeTabs.trolleybus)
            }
            .navigationBarTitle(navBarText)
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .onAppear() {
            self.busLinesViewModel.getBusLinesByType(
                refresh: false,
                completion: {
                    self.isBusy = false
            })
        }
    }
}

#if DEBUG
struct BusLinesView_Previews: PreviewProvider {
    static var previews: some View {
        BusLinesTabView()
    }
}
#endif
