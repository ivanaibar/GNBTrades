//
//  Array+Extensions.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 04/11/2020.
//

extension Array where Element: Hashable {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
            var set = Set<T>() //the unique list kept in a Set for fast retrieval
            var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
            for value in self {
                if !set.contains(map(value)) {
                    set.insert(map(value))
                    arrayOrdered.append(value)
                }
            }

            return arrayOrdered
        }
}
