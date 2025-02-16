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


/*

/// Without Protocols

class ProductService {
    let service = NetworkManager()
    
    func getAllProducts() async throws -> [Product] {
        let result: Result<[Product], NetworkError> = await service.request(
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
    
    func getSpecificProduct(id: Int) async throws -> Product {
        let result: Result<Product, NetworkError> = await service.request(
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


/// With Protocols

class MockProductService : ProductServiceProtocol {
    let network : NetworkServiceProtocol
    
    init(network : NetworkServiceProtocol = MockNetworkService()) {
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

class MockNetworkService : NetworkServiceProtocol {
    func request<T>(httpMethod: HTTPMethodType, endpoint: APIEndpoint, parameters: [String : Any]?) async -> Result<T, NetworkError> where T : Decodable {
        let jsonString = """
        [
            {
                "id": 1,
                "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                "price": 109.95,
                "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                "category": "men's clothing",
                "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                "rating": {
                    "rate": 3.9,
                    "count": 120
                }
            },
            {
                "id": 2,
                "title": "Mens Casual Premium Slim Fit T-Shirts",
                "price": 22.3,
                "description": "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
                "category": "men's clothing",
                "image": "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                "rating": {
                    "rate": 4.1,
                    "count": 259
                }
            }
        ]
        """
        let data = jsonString.data(using: .utf8)!
        let products = try! JSONDecoder().decode([Product].self, from: data)
        
        return .success(products as! T)
    }
    
    
}

*/
