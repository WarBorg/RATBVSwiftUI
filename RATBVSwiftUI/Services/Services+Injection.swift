//
//  Services+Injection.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 21/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation
import CoreData
import Resolver

extension Resolver {
    public static func registerServices(_ managedObjectContext: NSManagedObjectContext) {
        register { managedObjectContext as NSManagedObjectContext }
        register { AlamofireBusWebService() as BusWebService }
        register { CoreDataBusDataService(manageObjectContext: resolve()) as BusDataService }
        register { RealBusRepository() as BusRepository }
    }
}

