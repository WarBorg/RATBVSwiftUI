//
//  Date+Extensions.swift
//  RATBVSwiftUI
//
//  Created by Sergiu Cosmin on 22/06/2020.
//  Copyright © 2020 Sergiu Cosmin. All rights reserved.
//

import Foundation

extension Date {
    func formatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func localized() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
    
    static func formatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormatter.string(from: Date())
    }
    
    static func localized() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        return formatter.string(from: Date())
    }
}
