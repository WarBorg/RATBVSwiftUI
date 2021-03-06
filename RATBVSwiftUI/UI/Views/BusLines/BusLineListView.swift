//
//  BusLineListView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh

struct BusLineListView: View {
    @Binding var isBusy: Bool
    let busLines: [BusLinesViewModel.BusLineViewModel]
    let onRefresh: () -> Void
    var lastUpdateDate: String
    
    var body: some View {
        VStack {
            Text("Updated on \(lastUpdateDate)")
                .padding(.trailing)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .trailing)

                List(self.busLines, id: \.id) { busLine in
                    NavigationLink(destination: self.busStationsView(busLine: busLine)) {
                        BusLineCellView(busLineViewModel: busLine)
                    }
                }
                .pullToRefresh(isShowing: $isBusy, onRefresh: onRefresh)
        }
    }
}

private extension BusLineListView {
    func busStationsView(busLine : BusLinesViewModel.BusLineViewModel) -> some View {
        // Use lazy navigation view initialisation
        // NavigationLazyView(
        BusStationListView(
            busStationsViewModel: .init(busLineId: busLine.id,
                                        linkNormalWay: busLine.linkNormalWay,
                                        linkReverseWay: busLine.linkReverseWay),
            navBarTitle: busLine.name)
        // )
    }
}

#if DEBUG
//struct BusLineListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BusLineListView(
//            busLines: [BusLinesViewModel.BusLineViewModel(
//                busLine: BusLine(
//                    id: 0,
//                    name: "Test",
//                    route: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
//                    type: "Bus",
//                    linkNormalWay: "",
//                    linkReverseWay: ""))],
//            lastUpdateDate: "30.09.1985")
//    }
//}
#endif
