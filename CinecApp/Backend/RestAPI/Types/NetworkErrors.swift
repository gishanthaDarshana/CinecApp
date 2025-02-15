//
//  NetworkErrors.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation
enum NetworkError: Error {
    case noInternetConnection
    case invalidResponse
    case serverError(statusCode: Int, message: String?)
    case decodingError(Error)
    case unknown(Error)
}
