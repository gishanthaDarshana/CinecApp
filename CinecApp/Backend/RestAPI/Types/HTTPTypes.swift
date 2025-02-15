//
//  HTTPTypes.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation
import Alamofire

// Define an abstract HTTP method enum to avoid direct dependency on Alamofire
enum HTTPMethodType {
    case get, post, put, delete
    
    var alamofireMethod: HTTPMethod {
        switch self {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .delete: return .delete
        }
    }
}
