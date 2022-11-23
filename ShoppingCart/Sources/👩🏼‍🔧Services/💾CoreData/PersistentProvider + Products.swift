//
//  PersistentProvider + Products.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import CoreData

extension PersistentProvider: PersistentProviderProtocol {
    func update(
        models: [Product],
        action: PersistentState,
        completion: @escaping (Result<PersistentState, Error>) -> Void
    ) {
        switch action {
        case .add:
            backgroundViewContext.performAndWait {
                models.forEach {
                    // Updating.
                    if let product = try? self.fetchRequest(for: $0).execute().first {
                        product.update(with: $0)
                        completion(.success(.update))
                        // Adding.
                    } else {
                        let productCD = ProductCDModel(context: backgroundViewContext)
                        productCD.configNew(with: $0)
                        completion(.success(.add))
                    }
                }
                saveContext()
            }
            
        case .update:
            break
            
        case .remove:
            break
        }
    }
    
    func updateCountOfProduct(id: Int, count: Int) -> ProductCDModel? {
        var prod: ProductCDModel?
        mainViewContext.performAndWait {
            if let product = try? self.fetchRequest(by: id).execute().first {
                product.update(countOfProduct: count)
                prod = product
            }
            saveContext()
        }
        return prod
    }
    
    func fetchProducts() -> [ProductCDModel] {
        let request = ProductCDModel.fetchRequest()
        request.returnsObjectsAsFaults = false
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        let table = try? mainViewContext.fetch(request)
        guard let table = table else { return [ProductCDModel]() }
        return table
    }
    
    func deleteProduct(id: Int) {
        let request = ProductCDModel.fetchRequest()
        request.predicate = .init(format: "id == %i", id)
        let models = try? mainViewContext.fetch(request)
        for model in models ?? [] {
            mainViewContext.delete(model)
        }
        saveContext()
    }
}

// MARK: - FetchRequest with id CD Model Product and extension ProductCDModel
private extension PersistentProvider {
    func fetchRequest(for product: Product) -> NSFetchRequest<ProductCDModel> {
        let request = ProductCDModel.fetchRequest()
        request.predicate = .init(format: "id == %i", product.id)
        return request
    }
    
    func fetchRequest(by id: Int) -> NSFetchRequest<ProductCDModel> {
        let request = ProductCDModel.fetchRequest()
        request.predicate = .init(format: "id == %i", id)
        return request
    }
}

// MARK: - ProductCDModel
fileprivate extension ProductCDModel {
    func update(with product: Product) {
        count = Int64(1)
        title = product.title.capitalized
        productDescription = product.productDescription
        price = Int64(product.price)
        discountPercentage = product.discountPercentage
        rating = product.rating
        stock = Int64(product.stock)
        brand = product.brand.capitalized
        category = product.category
        thumbnail = product.thumbnail
        images = product.images
    }
    
    func update(countOfProduct: Int) {
        count = Int64(countOfProduct)
    }
    
    func configNew(with product: Product) {
        id = Int64(product.id)
        update(with: product)
    }
}
