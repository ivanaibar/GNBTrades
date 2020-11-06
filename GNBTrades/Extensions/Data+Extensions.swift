//
//  Data+Extensions.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 04/11/2020.
//

import Foundation

extension Data {
    
    func parse<T: Decodable>() -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: self)
        } catch let error {
            print(error)
        }
        return nil
    }
}
