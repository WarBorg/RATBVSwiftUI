//
//  ContentView.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 03/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @ObservedObject private var busLineViewModel = BusLinesViewModel()
    
    var body: some View {
        BusLinesTabView()
        //Text(busLineViewModel.busLines)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
