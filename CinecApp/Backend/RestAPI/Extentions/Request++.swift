//
//  Request++.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation
import Alamofire

extension Alamofire.DataRequest {
    public func debugLog() -> Self {
        // Log the cURL request
        cURLDescription { curl in
            print("🔹NETWORK REQUEST START=======================================")
            print(curl)
            print("🔹END========================================================")
        }
        
        return self.responseJSON { response in
            print("🔹NETWORK RESPONSE START=======================================")
            
            // Log response status
            if let httpResponse = response.response {
                print("\(httpResponse)")
            } else {
                print("No HTTP response received.")
            }

            // Handle the result (success or failure)
            switch response.result {
            case .success(let json):
                // Convert JSON to pretty-printed string for logging
                do {
                    // Convert JSON to pretty-printed string for logging
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    if let prettyString = String(data: jsonData, encoding: .utf8) {
                        print("🎉 Success! Here’s your JSON: \n\(prettyString) 💾")
                    }
                } catch {
                    // Log the error if JSON serialization fails
                    print("Failed to serialize JSON: \(error.localizedDescription)")
                }
            
            case .failure(let error):
                // Log the error description
                print("💥 Oops! Error Debug Print: \(error.localizedDescription) ⚠️")
                
                // Try to log the response data if available (e.g., for status code 429)
                if let data = response.data,
                   let errorString = String(data: data, encoding: .utf8) {
                    print("📜 Response Data: \n\(errorString)")
                } else {
                    print("No response data available.")
                }
            }
            
            print("🔹END========================================================")
        }

    }
}
