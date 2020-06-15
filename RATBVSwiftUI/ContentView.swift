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
        BusLinesView()
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
