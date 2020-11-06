//
//  RequestBuilder.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 04/11/2020.
//

import Foundation

public protocol RequestBuilder {
    
    var baseURL: URL { get }
    
    var path: String { get }
    
    var method: HttpMethod { get }
    
    var request: URLRequest { get }
    
}

public enum HttpMethod: String {
    case get, post
}
