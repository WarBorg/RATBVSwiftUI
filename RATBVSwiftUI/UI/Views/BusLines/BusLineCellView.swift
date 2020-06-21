//
//  BusLineCellView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 10/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusLineCellView: View {
    @ObservedObject var busLineViewModel : BusLinesViewModel.BusLineViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(busLineViewModel.name)
                .font(.title)
                .fontWeight(.medium)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
            Text(busLineViewModel.route)
                .font(.body)
                .fontWeight(.light)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
    }
}

#if DEBUG
struct BusLineListItemView_Previews: PreviewProvider {
    static var previews: some View {
        BusLineCellView(busLineViewModel: BusLinesViewModel.BusLineViewModel(
            busLine: BusLine(
                name: "Test",
                route: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                type: "Bus",
                linkNormalWay: "",
                linkReverseWay: "")))
    }
}
#endif
