//
//  BusStationListView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusStationListView: View {
    var body: some View {
        List {
            ForEach(0..<15) { item in
                NavigationLink(destination: BusTimetableListView()) {
                    Text("Station \(item)")
                }
            }
        }
        .navigationBarTitle(Text("Bus Stations"), displayMode: .inline)
    }
}

struct BusStationListView_Previews: PreviewProvider {
    static var previews: some View {
        BusStationListView()
    }
}
