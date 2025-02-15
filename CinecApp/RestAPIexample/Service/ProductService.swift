//
//  ProductService.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation
class ProductService : ProductServiceProtocol {
    
    let network : NetworkServiceProtocol
    
    init(network : NetworkServiceProtocol = NetworkManager()) {
        self.network = network
    }
    
    func getProducts() async throws -> [Product] {
        let result: Result<[Product], NetworkError> = await network.request(
                httpMethod: .get,
                endpoint: .products, parameters: nil
            )
        
        switch result {
            case .success(let products):
            return products
        case .failure(let error):
            throw error
        }
    }
    
    func getProduct(id: Int) async throws -> Product {
        let result: Result<Product, NetworkError> = await network.request(
            httpMethod: .get,
            endpoint: .productDetails(id: id), parameters: nil
        )
        
        switch result {
        case .success(let product):
            return product
        case .failure(let error):
            throw error
        }
    }

}
