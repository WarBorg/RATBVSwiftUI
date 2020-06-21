//
//  BusLineListView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusLineListView: View {
    let busLines: [BusLinesViewModel.BusLineViewModel]
    let lastUpdateDate: String
    
    var body: some View {
        VStack {
            Text("Updated on \(lastUpdateDate)")
                .padding(.trailing)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            List(busLines, id: \.id) { busLine in
                NavigationLink(destination: BusStationListView(navBarTitle: busLine.name)) {
                    BusLineCellView(busLineViewModel: busLine)
                }
            }
        }
    }
}

#if DEBUG
struct BusLineListView_Previews: PreviewProvider {
    static var previews: some View {
        BusLineListView(
            busLines: [BusLinesViewModel.BusLineViewModel(
                busLine: BusLine(
                    id: 0,
                    name: "Test",
                    route: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    type: "Bus",
                    linkNormalWay: "",
                    linkReverseWay: ""))],
            lastUpdateDate: "30.09.1985")
    }
}
#endif
