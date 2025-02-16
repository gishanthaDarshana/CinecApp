//
//  ProductView.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-16.
//
import SwiftUI

struct ProductView: View {
    @StateObject private var productDetailViewModel: ProductDetailViewModel = .init()
    
    let productId: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: URL(string: productDetailViewModel.productDetail?.image ?? "")) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            .cornerRadius(10)
            
            Text(productDetailViewModel.productDetail?.title ?? "")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.horizontal)
            
            Text("$\(productDetailViewModel.productDetail?.price ?? 0.0, specifier: "%.2f")")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.horizontal)
            
            HStack {
                Text("⭐️ \(String(format: "%.1f", productDetailViewModel.productDetail?.rating.rate ?? 0.0)) (\(productDetailViewModel.productDetail?.rating.count ?? 0) Reviews)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            Text(productDetailViewModel.productDetail?.description ?? "")
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Product Details")
    }
}

#Preview {
    ProductView(productId: 20)
}
