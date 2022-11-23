//
//  PersistentProvider.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 22.11.2022.
//

import CoreData

final class PersistentProvider {
    private var persistentContainer: NSPersistentContainer!
    var mainViewContext: NSManagedObjectContext!
    var backgroundViewContext: NSManagedObjectContext!
    
    init() {
        let container = NSPersistentContainer(name: PersistentConstants.target)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer = container
        mainViewContext = persistentContainer?.viewContext
        backgroundViewContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundViewContext.parent = mainViewContext
    }
    
    func saveContext() {
        if backgroundViewContext.hasChanges {
            do {
                try backgroundViewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        if mainViewContext.hasChanges {
            do {
                try mainViewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
