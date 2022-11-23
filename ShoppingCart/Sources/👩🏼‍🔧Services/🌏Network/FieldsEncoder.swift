//
//  FieldsEncoder.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import Foundation

struct FieldsEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: [String: String]?) {
        guard let fields = parameters else { return }
        for field in fields where urlRequest.value(forHTTPHeaderField: field.key) == nil {
//            if urlRequest.value(forHTTPHeaderField: field.key) == nil {
                urlRequest.setValue(field.value, forHTTPHeaderField: field.key)
//            }
        }
    }
}
