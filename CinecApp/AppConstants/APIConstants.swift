//
//  APIConstants.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//


struct APIConstants {
    static let baseURL = "https://fakestoreapi.com"
    
    struct Endpoints {
        static let products = "/products"
        static let productDetails = "/products/{id}"
    }
}

// Define API Endpoint Enum
enum APIEndpoint {
    case products
    case productDetails(id: Int)
    
    var path: String {
        switch self {
        case .products:
            return "/products"
        case .productDetails(let id):
            return "/products/\(id)"
        }
    }
    
    var url: String {
        return "\(APIConstants.baseURL)\(path)"
    }
}