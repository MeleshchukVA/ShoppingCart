//
//  ImageCache.swift
//  ShoppingCart
//
//  Created by Владимир Мелещук on 16.12.2022.
//

import UIKit

public let LRUCacheMemoryWarningNotification: NSNotification.Name =
    UIApplication.didReceiveMemoryWarningNotification

// MARK: - LRUCache class

public final class LRUCache<Key: Hashable, Value> {
    
    // MARK: Private properties
    private var values: [Key: Container] = [:]
    private unowned(unsafe) var head: Container?
    private unowned(unsafe) var tail: Container?
    private let lock: NSLock = .init()
    private var token: AnyObject?
    private let notificationCenter: NotificationCenter
    
    // MARK: Public properties
    
    // Текущая общая стоимость значений в кэше.
    public private(set) var totalCost: Int = 0

    // Максимально допустимый общий размер кэша.
    public var totalCostLimit: Int {
        didSet { clean() }
    }

    // Максимально допустимое число элементов в кэше.
    public var countLimit: Int {
        didSet { clean() }
    }
    
    // MARK: Init
    // Инициализируем кэш с указанными `totalCostLimit` и `countLimit`.
    public init(
        totalCostLimit: Int = .max,
        countLimit: Int = .max,
        notificationCenter: NotificationCenter = .default
    ) {
        self.totalCostLimit = totalCostLimit
        self.countLimit = countLimit
        self.notificationCenter = notificationCenter

        self.token = notificationCenter.addObserver(
            forName: LRUCacheMemoryWarningNotification,
            object: nil,
            queue: nil
        ) { [weak self] _ in
            self?.removeAllValues()
        }
    }
    
    // MARK: Deinit
    deinit {
        if let token = token {
            notificationCenter.removeObserver(token)
        }
    }
}

// MARK: - LRUCache public extension

public extension LRUCache {
    
    // Количество значений, хранящихся в настоящее время в кэше.
    var count: Int {
        values.count
    }

    // Кэш пуст?
    var isEmpty: Bool {
        values.isEmpty
    }

    // Вставка значения в кэш с опциональным параметром `cost`.
    func setValue(_ value: Value?, forKey key: Key, cost: Int = 0) {
        guard let value = value else {
            removeValue(forKey: key)
            return
        }
        
        lock.lock()
        
        if let container = values[key] {
            container.value = value
            totalCost -= container.cost
            container.cost = cost
            remove(container)
            append(container)
        } else {
            let container = Container(
                value: value,
                cost: cost,
                key: key
            )
            values[key] = container
            append(container)
        }
        totalCost += cost
        lock.unlock()
        clean()
    }

    // Remove a value from the cache and return it.
    @discardableResult func removeValue(forKey key: Key) -> Value? {
        lock.lock()
        defer { lock.unlock() }
        guard let container = values.removeValue(forKey: key) else {
            return nil
        }
        remove(container)
        totalCost -= container.cost
        return container.value
    }

    // Удалить значение из кэша и вернуть его.
    func value(forKey key: Key) -> Value? {
        lock.lock()
        defer { lock.unlock() }
        if let container = values[key] {
            remove(container)
            append(container)
            return container.value
        }
        return nil
    }

    // Удалить все значения из кэша.
    func removeAllValues() {
        lock.lock()
        values.removeAll()
        head = nil
        tail = nil
        lock.unlock()
    }
}

// MARK: - LRUCache private extension

private extension LRUCache {
    
    // MARK: Container class
    final class Container {
        
        var value: Value
        var cost: Int
        let key: Key
        unowned(unsafe) var prev: Container?
        unowned(unsafe) var next: Container?

        init(value: Value, cost: Int, key: Key) {
            self.value = value
            self.cost = cost
            self.key = key
        }
    }

    // Удалить контейнер из списка.
    func remove(_ container: Container) {
        if head === container {
            head = container.next
        }
        if tail === container {
            tail = container.prev
        }
        container.next?.prev = container.prev
        container.prev?.next = container.next
        container.next = nil
    }

    // Добавить контейнер в список.
    func append(_ container: Container) {
        assert(container.next == nil)
        if head == nil {
            head = container
        }
        container.prev = tail
        tail?.next = container
        tail = container
    }
    
    // Очистить контейнер.
    func clean() {
        lock.lock()
        defer { lock.unlock() }
        while totalCost > totalCostLimit || count > countLimit,
              let container = head {
            remove(container)
            values.removeValue(forKey: container.key)
            totalCost -= container.cost
        }
    }
}
