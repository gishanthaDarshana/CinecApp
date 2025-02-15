//
//  ProductListViewModel.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation

@MainActor
class ProductListViewModel : ObservableObject {
    let service : ProductServiceProtocol
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    @Published var products : [Product] = []
    
    func fetchProducts() {
        Task {
            do {
                let products = try await self.service.getProducts()
                self.products = products.sorted { $0.title < $1.title }
            } catch {
                print("Error fetching products: \(error)")
            }
        }
    }
}
