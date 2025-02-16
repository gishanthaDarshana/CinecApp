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
    @Published var errorMessage : String = ""
    @Published var isLoading : Bool = false
    
    func fetchProducts() {
        errorMessage = ""
        
        Task {
            do {
                isLoading = true
                let products = try await self.service.getProducts()
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
