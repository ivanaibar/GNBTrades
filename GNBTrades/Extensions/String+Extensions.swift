//
//  String+Extensions.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 05/11/2020.
//

import Foundation

extension String {
    
    func toDecimalWithAutoLocale() -> Decimal? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        //** US,CAD,GBP formatted
        formatter.locale = Locale(identifier: "en_US")

        if let number = formatter.number(from: self) {
            return number.decimalValue
        }
        
        //** EUR formatted
        formatter.locale = Locale(identifier: "es_ES")

        if let number = formatter.number(from: self) {
           return number.decimalValue
        }
        
        return nil
    }
}
