//
//  BusTimetableListView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusTimetableListView: View {
    let busTimetables: [BusTimetablesViewModel.BusTimetableViewModel]
    let lastUpdateDate: String
    
    var body: some View {
        VStack {
            Text("Updated on \(lastUpdateDate)")
                .padding(.trailing)
                .padding(.top)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            GeometryReader { geometry in
                HStack() {
                    Text("Hour")
                        .font(.headline)
                        .frame(width: geometry.size.width * 0.20)
                    Text("Minutes")
                        .font(.headline)
                        .frame(width: geometry.size.width * 0.80)
                }
            }
            .padding()
            
            List(busTimetables, id: \.id) { busTimetable in
                BusTimetableCellView(busTimetableViewModel: busTimetable)
            }
            .layoutPriority(100)
        }
    }
}

#if DEBUG
struct BusTimetableListView_Previews: PreviewProvider {
    static var previews: some View {
        BusTimetableListView(
            busTimetables: [BusTimetablesViewModel.BusTimetableViewModel(
                busTimetable: BusTimetable(
                    hour: "15",
                    minutes: "02 11 20 29 38 48",
                    timeOfWeek: "Saturday"))],
            lastUpdateDate: "30.09.1985"
        )
    }
}
#endif
