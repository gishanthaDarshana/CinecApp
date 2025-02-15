//
//  Product.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//


import Foundation

// MARK: - Product
struct Product: Codable , Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}
