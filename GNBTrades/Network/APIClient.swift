//
//  APIClient.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 04/11/2020.
//

import Foundation

protocol ApiClient {
    func getData(of request: RequestBuilder, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class HTTPClient: ApiClient {
    
    func getData(of request: RequestBuilder, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request.request) { data, response, error in
            if let error = error {
                completion(.failure(.apiError(error.localizedDescription)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200 ... 299).contains(httpResponse.statusCode) else {
                completion(.failure(.outOfRange))
                return
            }
            guard let data = data else {
                completion(.failure(.dataIsNil))
                return
            }
            completion(.success(data))
        }

        task.resume()
    }
}
