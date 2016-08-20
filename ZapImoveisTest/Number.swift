//
//  Number.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/20/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

struct Number {
    static let formatterWithSepator: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .DecimalStyle
        return formatter
    }()
}
extension IntegerType {
    var stringFormatedWithSepator: String {
        return Number.formatterWithSepator.stringFromNumber(hashValue) ?? ""
    }
}