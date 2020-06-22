//
//  AppDelegate+Injection.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import UIKit
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        registerViewModels()
        registerServices(context)
    }
}
