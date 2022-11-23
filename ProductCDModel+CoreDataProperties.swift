//
//  ProductCDModel+CoreDataProperties.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//
//

import Foundation
import CoreData

extension ProductCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductCDModel> {
        return NSFetchRequest<ProductCDModel>(entityName: PersistentConstants.productModel)
    }

    @NSManaged public var brand: String?
    @NSManaged public var category: String?
    @NSManaged public var count: Int64
    @NSManaged public var discountPercentage: Double
    @NSManaged public var id: Int64
    @NSManaged public var images: [String]?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var price: Int64
    @NSManaged public var productDescription: String?
    @NSManaged public var rating: Double
    @NSManaged public var stock: Int64
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
}
