//
//  ProductDetailViewModel.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-16.
//

import Foundation
class ProductDetailViewModel : ObservableObject {
    let service : ProductServiceProtocol
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    @Published var productDetail : Product?
    
    func getProductDetail(id: Int) {
        Task{
            do {
                let productDetail = try await self.service.getProduct(id: id)
                self.productDetail = productDetail
            } catch {
                print("Error \(error)")
            }
        }
    }
}
