//
//  BusTimetableCellView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusTimetableCellView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack() {
                Text("15")
                    .frame(width: geometry.size.width * 0.20, height: geometry.size.height)
                Text("02 11 20 29 38 48")
                    .frame(width: geometry.size.width * 0.80, height: geometry.size.height, alignment: .leading)
            }
        }
    }
}

struct BusTimetableCellView_Previews: PreviewProvider {
    static var previews: some View {
        BusTimetableCellView()
    }
}
