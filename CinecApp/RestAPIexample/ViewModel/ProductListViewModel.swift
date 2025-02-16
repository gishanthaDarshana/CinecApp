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
    //let service = ProductService()
    
    //init(service: ProductServiceProtocol = MockProductService()) {
    //    self.service = service
    //}
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }

    
    @Published var products : [Product] = []
    @Published var errorMessage : String = ""
    @Published var isLoading : Bool = false
    
    func fetchProducts() {
        errorMessage = ""
        
        Task {
            do {
                isLoading = true
                let products = try await self.service.getProducts()
                //let products = try await self.service.getAllProducts()
                self.products = products.sorted { $0.title < $1.title }
                isLoading = false
            } catch {
                switch error {
                case let serviceError as NetworkError:
                    switch serviceError {
                    case .decodingError:
                        errorMessage = "Error decoding products data."
                    case .unknown(let underlyingError):
                        errorMessage = "Unknown error: \(underlyingError)"
                    case .invalidURL:
                        errorMessage = "Invalid URL used for the API request."
                    case .invalidRequest:
                        errorMessage = "Invalid request parameters provided."
                    case .noInternetConnection:
                        errorMessage = "No internet connection available."
                    case .invalidResponse:
                        errorMessage = "Invalid response format from the server."
                    case .serverError(statusCode: let statusCode, message: let message):
                        guard let message = message else {
                            errorMessage = "Server error: Status code \(statusCode)."
                            break
                        }
                        errorMessage = "Error:- \(String(describing: message))"
                    }
                default:
                    print("Error fetching products: \(error)")
                    errorMessage = "Error fetching products: \(error)"
                }
                isLoading = false
            }
        }
    }
}


/// Wrong way of managing a view model

/*
@MainActor
class ProductListViewModelWrong : ObservableObject {
    
    let service = NetworkManager()
    
    @Published var products : [Product] = []
    @Published var errorMessage : String = ""
    @Published var isLoading : Bool = false
    
    func fetchProducts() {
        Task {
            let result: Result<[Product], NetworkError> = await service.request(
                httpMethod: .get,
                    endpoint: .products, parameters: nil
                )
            
            switch result {
                case .success(let products):
                self.products = products
            case .failure(let error):
                switch error {
                    
                case .decodingError:
                    errorMessage = "Error decoding products data."
                case .unknown(let underlyingError):
                    errorMessage = "Unknown error: \(underlyingError)"
                case .invalidURL:
                    errorMessage = "Invalid URL used for the API request."
                case .invalidRequest:
                    errorMessage = "Invalid request parameters provided."
                case .noInternetConnection:
                    errorMessage = "No internet connection available."
                case .invalidResponse:
                    errorMessage = "Invalid response format from the server."
                case .serverError(statusCode: let statusCode, message: let message):
                    guard let message = message else {
                        errorMessage = "Server error: Status code \(statusCode)."
                        break
                    }
                    errorMessage = "Error:- \(String(describing: message))"
                }
            }
        }
        
    }
    
    func fetchSpecificProduct(id : Int) {
        Task {
            let result: Result<[Product], NetworkError> = await service.request(
                httpMethod: .get,
                    endpoint: .productDetails(id: id), parameters: nil
                )
            
            switch result {
                case .success(let products):
                self.products = products
            case .failure(let error):
                throw error
            }
        }
        
    }
}
*/
