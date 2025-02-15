//
//  ProductServiceProtocol.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import Foundation
protocol ProductServiceProtocol {
    func getProducts() async throws -> [Product]
    func getProduct(id: Int) async throws -> Product
}
