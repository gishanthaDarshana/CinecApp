//
//  NetworkingProtocols.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation
protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        httpMethod: HTTPMethodType,
        endpoint: APIEndpoint,
        parameters: [String: Any]?
    ) async -> Result<T, NetworkError>
}
