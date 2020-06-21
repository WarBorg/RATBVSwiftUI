//
//  BusStationListView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusStationListView: View {
    @ObservedObject private(set) var busStationsViewModel: BusStationsViewModel
    let navBarTitle: String
    
    var body: some View {
        VStack {
            Text("Updated on \(busStationsViewModel.lastUpdateDate)")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top)
            
            List(busStationsViewModel.busStations, id: \.id) { busStation in
                NavigationLink(destination: self.busTimetablesView(busStation: busStation)) {
                    Text(busStation.name)
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                }
            }
            .navigationBarTitle(Text(navBarTitle), displayMode: .inline)
        .navigationBarItems(
            trailing:
                HStack(spacing: 20) {
                    Button(action: {
                        print("Reverse icon pressed...")
                    }) {
                        Image(systemName: "repeat")
                            .imageScale(.large)
                    }
                
                    Button(action: {
                        print("Download icon pressed...")
                    }) {
                        Image(systemName: "icloud.and.arrow.down")
                            .imageScale(.large)
                    }
                }
            )
        }
    }
}

private extension BusStationListView {
    func busTimetablesView(busStation : BusStationsViewModel.BusStationViewModel) -> some View {
        BusTimetablesView(
            busTimetablesViewModel: .init(busStationId: busStation.id,
                                          scheduleLink: busStation.scheduleLink),
            navBarTitle: busStation.name)
    }
}

#if DEBUG
/*struct BusStationListView_Previews: PreviewProvider {
    static var previews: some View {
        BusStationListView(navBarTitle: "Test")
    }
}*/
#endif
