//
//  NetworkService.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 26.10.2022.
//

import Foundation

enum NetworkErrors: Error {
    case wrongURL
    case dataIsEmpty
    case decodeIsFail
    case failEncodeBodyData
}

final class NetworkService {
    func baseRequest<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        body: [String: Any]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkErrors.wrongURL))
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue.uppercased()
        
        if let body = body {
            if let bodyData = try? JSONSerialization.data(withJSONObject: body) {
                request.httpBody = bodyData
                let headers = ["Content-Type": "application/json"]
                FieldsEncoder.encode(urlRequest: &request, with: headers)
            } else {
                completion(.failure(NetworkErrors.wrongURL))
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            print("curl \(url)")
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkErrors.dataIsEmpty))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedModel = try decoder.decode(T.self, from: data)
                completion(.success(decodedModel))
            } catch {
                completion(.failure(NetworkErrors.decodeIsFail))
            }
        }.resume()
    }
}
