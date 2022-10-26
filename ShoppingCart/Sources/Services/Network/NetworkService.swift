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
}

final class NetworkService {
    
    // Базовый запрос.
    func baseRequest<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkErrors.wrongURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            print(url)
            
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
