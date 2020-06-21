//
//  AppDelegate+Injection.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerViewModels()
        registerServices()
    }
}
