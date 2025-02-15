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
            .responseDecodable(of: T.self) { response in
                if let statusCode = response.response?.statusCode, !(200...299).contains(statusCode) {
                    let errorMessage = (try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String: Any])?["message"] as? String
                    continuation.resume(returning: .failure(.serverError(statusCode: statusCode, message: errorMessage)))
                    return
                }
                
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: .success(data))
                case .failure(let error):
                    if let afError = error.asAFError, afError.isSessionTaskError {
                        continuation.resume(returning: .failure(.noInternetConnection))
                    } else if let decodingError = error as? DecodingError {
                        continuation.resume(returning: .failure(.decodingError(decodingError)))
                    } else {
                        continuation.resume(returning: .failure(.unknown(error)))
                    }
                }
            }
        }
    }
}
