//
//  CatalogueViewModel.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 27.10.2022.
//

import Foundation

// MARK: - CatalogueViewModel + Identifiable

struct CatalogueViewModel: Identifiable {
    
    var id: UUID
    var name: String
}

// MARK: - CatalogueViewModel + Hashable

extension CatalogueViewModel: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
