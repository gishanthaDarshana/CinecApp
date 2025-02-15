//
//  ProductListView.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel: ProductListViewModel = .init()
    var body: some View {
        List(viewModel.products) { product in
            NavigationLink {
                ProductView(productId: product.id)
            } label: {
                Text(product.title)
            }
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}

#Preview {
    ProductListView()
}
