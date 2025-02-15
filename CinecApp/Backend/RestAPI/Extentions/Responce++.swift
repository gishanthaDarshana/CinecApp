//
//  Responce++.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation
import Alamofire

extension DataResponse {
    func logResponse() {
        if let url = self.request?.url?.absoluteString,
           let statusCode = self.response?.statusCode {
            print("\n[RESPONSE] \nURL: \(url)\nStatus Code: \(statusCode)\n")
        }
        if let data = self.data, let jsonString = String(data: data, encoding: .utf8) {
            print("Response Data: \n\(jsonString)\n")
        }
        if let error = self.error {
            print("Error: \(error.localizedDescription)\n")
        }
    }
}
