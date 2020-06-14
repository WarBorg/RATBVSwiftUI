//
//  BusLineListView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusLineListView: View {
    let startIndex: Int
    
    var body: some View {
        List {
            Text("Updated on 6/8/2020 21:38")
                .padding(.trailing)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            ForEach(0..<15) { item in
                NavigationLink(destination: BusStationListView()) {
                    BusLineListItemView(itemNumber: item + self.startIndex)
                        .navigationBarTitle("Linia \(item + self.startIndex)")
                }
            }
        }
    }
}

struct BusLineListView_Previews: PreviewProvider {
    static var previews: some View {
        BusLineListView(startIndex: 0)
    }
}
