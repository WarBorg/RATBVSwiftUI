//
//  ViewModels+Injection.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerViewModels() {
        register { BusLinesViewModel() }
        //register { BusStationsViewModel() }
        //register { BusTimetablesViewModel() }
    }
}
