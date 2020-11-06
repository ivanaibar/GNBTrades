//
//  NetworkError.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 04/11/2020.
//

import Foundation

enum NetworkError: LocalizedError {
    case generalFailure
    case failedToParseData
    case dataIsNil
    case connectionFailed
    case outOfRange
    case apiError(String)
    var errorDescription: String? {
        switch self {
        case .failedToParseData:
            return "Technical Difficults, we can't fetch the data"
        default:
            return "Check your connectivity"
        }
    }
}
