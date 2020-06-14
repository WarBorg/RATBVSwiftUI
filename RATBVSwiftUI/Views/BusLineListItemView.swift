//
//  BusLineListItemView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 10/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusLineListItemView: View {
    let itemNumber: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Line \(itemNumber)")
                .font(.title)
                .fontWeight(.medium)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
            Text("On the other hand, we denounce with righteous indignation and dislike men who cdscs cdscs  cdscsd cdscsdc")
                .font(.body)
                .fontWeight(.light)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
    }
}





struct BusLineListItemView_Previews: PreviewProvider {
    static var previews: some View {
        BusLineListItemView(itemNumber: 5)
    }
}
