//
//  RoundedTextFieldModifier.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//


import SwiftUI

struct RoundedTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white) // Set the background color
            .cornerRadius(10) // Round the corners
            .shadow(radius: 5) // Optional: Add a subtle shadow for effect
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1) // Ash-colored border
            )
            .padding([.leading, .trailing], 16)
    }
}

extension View {
    func roundedTextFieldStyle() -> some View {
        self.modifier(RoundedTextFieldModifier())
    }
}
