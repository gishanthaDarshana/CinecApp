//
//  NetworkManager.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation
import Alamofire

class NetworkManager: NetworkServiceProtocol {
    func request<T: Decodable>(
        httpMethod: HTTPMethodType,
        endpoint: APIEndpoint,
        parameters: [String: Any]? = nil
    ) async -> Result<T, NetworkError> {
        return await withCheckedContinuation { continuation in
            AF.request(
                endpoint.url,
                method: httpMethod.alamofireMethod,
                parameters: parameters,
                encoding: JSONEncoding.default
            ).debugLog()
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                let statusCode = response.response?.statusCode ?? -1                            
                // Handle Alamofire result
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: .success(data))
                    
                case .failure(let error):
                    continuation.resume(returning: .failure(self.mapAlamofireError(error, statusCode: statusCode)))
                }
            }
        }
    }
    
    // Helper function to map Alamofire errors to NetworkError
    private func mapAlamofireError(_ error: AFError, statusCode: Int) -> NetworkError {
        switch error {
        case .invalidURL:
            return .invalidURL
        case .responseSerializationFailed:
            return .invalidResponse
        case .parameterEncodingFailed, .parameterEncoderFailed:
            return .serverError(statusCode: statusCode, message: "Parameter Encoding Failed")
        case .multipartEncodingFailed:
            return .serverError(statusCode: statusCode, message: "Multipart Encoding Failed")
        default:
            return .serverError(statusCode: statusCode, message: error.localizedDescription)
        }
    }
}
