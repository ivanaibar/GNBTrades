//
//  ProductTransactionsApi.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 05/11/2020.
//

import Foundation

enum ProductTransactionsApi {
    case getRates
}

extension ProductTransactionsApi: RequestBuilder {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getRates:
            return "rates"
        }
    }
    
    private var endpoint: URL {
        return URL(string: "\(baseURL)\(path)")!
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var request: URLRequest {
        let urlComponents = URLComponents(string: endpoint.absoluteString)
        var request = URLRequest(url: urlComponents!.url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
