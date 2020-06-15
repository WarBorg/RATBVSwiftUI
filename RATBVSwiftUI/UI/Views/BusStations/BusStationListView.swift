//
//  BusStationListView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 14/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct BusStationListView: View {
    let navBarTitle: String
    
    var body: some View {
        VStack {
            Text("Updated on 6/8/2020 21:38")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top)
            
            List {
                ForEach(0..<15) { item in
                    NavigationLink(destination:
                    BusTimetablesView(navBarTitle: "Station \(item)")) {
                        Text("Station \(item)")
                            .font(.system(size: 26))
                            .fontWeight(.medium)
                            .lineLimit(1)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
            .navigationBarTitle(Text(navBarTitle), displayMode: .inline)
        .navigationBarItems(
            trailing:
                HStack(spacing: 20) {
                    Button(action: {
                        print("Reverse icon pressed...")
                    }) {
                        Image(systemName: "repeat")
                            .imageScale(.large)
                    }
                
                    Button(action: {
                        print("Download icon pressed...")
                    }) {
                        Image(systemName: "icloud.and.arrow.down")
                            .imageScale(.large)
                    }
                }
            )
        }
    }
}

#if DEBUG
struct BusStationListView_Previews: PreviewProvider {
    static var previews: some View {
        BusStationListView(navBarTitle: "Test")
    }
}
#endif
