//
//  BusTimetableListView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusTimetableListView: View {
    var body: some View {
        VStack {
            Text("Updated on 6/8/2020 21:38")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top)
            
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
            
            List {
                ForEach(0..<15) { item in
                    BusTimetableCellView()
                }
            }
            .layoutPriority(100)
        }
    }
}

struct BusTimetableListView_Previews: PreviewProvider {
    static var previews: some View {
        BusTimetableListView()
    }
}
