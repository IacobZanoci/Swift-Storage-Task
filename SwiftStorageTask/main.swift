//
//  main.swift
//  SwiftStorageTask
//
//  Created by Iacob Zanoci on 25.07.2025.
//

import Foundation

/**
 The task is to implement the Shop protocol (you can do that in this file directly).
 - No database or any other storage is required, just store data in memory
 - No any smart search, use String method contains (case sensitive/insensitive - does not matter)
 - Performance optimizations for listProductsByName and listProductsByProducer are optional
 */
struct Product {
    let id: String // unique identifier
    let name: String
    let producer: String
}

protocol Shop {
    /**
     Adds a new product object to the Shop.
     - Parameter product: product to add to the Shop
     - Returns: false if the product with same id already exists in the Shop, true – otherwise.
     */
    func addNewProduct(product: Product) -> Bool
    
    /**
     Deletes the product with the specified id from the Shop.
     - Returns: true if the product with same id existed in the Shop, false – otherwise.
     */
    func deleteProduct(id: String) -> Bool
    
    /**
     - Returns: 10 product names containing the specified string.
     If there are several products with the same name, producer's name is added to product's name in the format "<producer> - <product>",
     otherwise returns simply "<product>".
     */
    func listProductsByName(searchString: String) -> Set<String>
    
    /**
     - Returns: 10 product names whose producer contains the specified string, result is ordered by producers.
     */
    func listProductsByProducer(searchString: String) -> [String]
}

// TODO: Implementation
class ShopImpl: Shop {
    
    private var products: [String: Product] = [:]
    
    // MARK: - Add
    
    func addNewProduct(product: Product) -> Bool {
        guard products[product.id] == nil else {
            return false
        }
        
        products[product.id] = product
        return true
    }
    
    // MARK: - Delete
    
    func deleteProduct(id: String) -> Bool {
        guard products[id] != nil else {
            return false
        }
        
        products.removeValue(forKey: id)
        return true
    }
    
    // MARK: - List by Name
    
    func listProductsByName(searchString: String) -> Set<String> {
        // Filter products's names that contains the 'searchString'
        let filtered = products.values.filter { $0.name.localizedCaseInsensitiveContains(searchString) }
        
        // Group products by name (temporary dictionary grouped by name)
        let grouped = Dictionary(grouping: filtered, by: { $0.name })
        
        var result = Set<String>()
        
        // For loop for iteration over each group
        for (name, productsGroup) in grouped {
            if productsGroup.count == 1 {
                // add only one product with same name
                result.insert(name)
            } else {
                // add multiple products with same name (<producer> - <product>)
                for product in productsGroup {
                    result.insert("\(product.producer) - \(product.name)")
                }
            }
            
            if result.count >= 10 {
                break
            }
        }
        
        if result.count > 10 {
            return Set(result.prefix(10))
        }
        return result
    }
    
    // MARK: - List by Producer
    
    func listProductsByProducer(searchString: String) -> [String] {
        // Filter products's producers that contains the 'searchString'
        let filtered = products.values.filter { $0.producer.localizedCaseInsensitiveContains(searchString) }
        
        // Sort filtered products by producer name
        let sorted = filtered.sorted { $0.producer.localizedCaseInsensitiveCompare($1.producer) == .orderedAscending }
        
        // Map to product names
        let productNames = sorted.map { $0.name }
        
        if productNames.count > 10 {
            return Array(productNames.prefix(10))
        }
        
        return productNames
    }
}

// MARK: - Debugging

let shop = ShopImpl()

let product1 = Product(id: "1", name: "Book-1", producer: "Author-1")
let product2 = Product(id: "1", name: "Book-1", producer: "Author-2")
let product3 = Product(id: "3", name: "Book-3", producer: "Author-3")
let product4 = Product(id: "4", name: "Book-4", producer: "Author-4")
let product5 = Product(id: "5", name: "Book-4", producer: "Author-5")
let product6 = Product(id: "6", name: "Book-6", producer: "Author-6")
let product7 = Product(id: "7", name: "Book-7", producer: "Author-7")
let product8 = Product(id: "8", name: "Book-8", producer: "Author-8")
let product9 = Product(id: "9", name: "Book-9", producer: "Author-9")

// Add New Product
print("Add New Product:")
print(shop.addNewProduct(product: product1)) // true
print(shop.addNewProduct(product: product2)) // false (already exists)
print(shop.addNewProduct(product: product3)) // true
print(shop.addNewProduct(product: product4)) // true

// Delete Product
print("\nDelete Product:")
print(shop.deleteProduct(id: "3")) // true (removed)
print(shop.deleteProduct(id: "3")) // false (already removed)

// List Products by Name
_ = shop.addNewProduct(product: product4)
_ = shop.addNewProduct(product: product5)
_ = shop.addNewProduct(product: product6)

let searchResult1 = shop.listProductsByName(searchString: "Book-4")
let searchResult2 = shop.listProductsByName(searchString: "Book-6")

print("\nList Products by Name:")
print(searchResult1) // ["Author-4 - Book-4", "Author-5 - Book-4"]
print(searchResult2) // ["Book-6"]

// List Products by Producer
_ = shop.addNewProduct(product: product7)
_ = shop.addNewProduct(product: product8)
_ = shop.addNewProduct(product: product9)

let result = shop.listProductsByProducer(searchString: "Author")

print("\nList Products by Producer:")

for productName in result {
    print(productName) // Book-1 Book-4 Book-4 Book-6 Book-7 Book-8 Book-9
}
