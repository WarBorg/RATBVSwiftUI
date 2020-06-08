//
//  ContentView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 03/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .trailing) {
                Text("Updated on 6/8/2020 21:38")
                    .padding(.trailing)
                    .font(.headline)
                List {
                    ForEach(0..<15) { item in
                        VStack(alignment: .leading) {
                            Text("Line \(item)")
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
            }
            .navigationBarTitle(Text("Bus Lines"), displayMode:
            .inline)
        }
    }
}

































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
