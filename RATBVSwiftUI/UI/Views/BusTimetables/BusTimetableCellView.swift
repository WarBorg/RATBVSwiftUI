//
//  BusTimetableCellView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusTimetableCellView: View {
    @ObservedObject var busTimetableViewModel : BusTimetablesViewModel.BusTimetableViewModel
    
    var body: some View {
        GeometryReader { geometry in
            HStack() {
                Text(self.busTimetableViewModel.hour)
                    .frame(width: geometry.size.width * 0.20, height: geometry.size.height)
                Text(self.busTimetableViewModel.minutes)
                    .frame(width: geometry.size.width * 0.80, height: geometry.size.height, alignment: .leading)
            }
        }
    }
}

#if DEBUG
struct BusTimetableCellView_Previews: PreviewProvider {
    static var previews: some View {
        BusTimetableCellView(busTimetableViewModel: BusTimetablesViewModel.BusTimetableViewModel(
            busTimetable: BusTimetable(
                oid: 1,
                hour: "15",
                minutes: "02 11 20 29 38 48",
                timeOfWeek: "Saturday")))
    }
}
#endif
