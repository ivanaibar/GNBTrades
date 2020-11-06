//
//  Decimal+Extensions.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 05/11/2020.
//

import Foundation

extension Decimal {
    
    func rounded(_ scale: Int, _ roundingMode: RoundingMode = .bankers) -> Decimal {
            var toRound = self
            var rounded = Decimal()
            NSDecimalRound(&rounded, &toRound, scale, roundingMode)
            return rounded
    }
}


