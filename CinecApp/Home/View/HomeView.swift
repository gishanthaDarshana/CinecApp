//
//  HomeView.swift
//  CinecApp
//
//  Created by Gishantha Darshana on 2025-02-15.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack (alignment : .top){
                Color.white
                    .navigationBarTitle("Home", displayMode: .inline)
                
                VStack(alignment : .leading){
                    List {
                        NavigationLink(destination: StudentsList()) {
                                Text("FireBase Realtime Example")
                            }
                        NavigationLink(destination: Text("Second View")) {
                                Text("REST API Example")
                            }
                    }
                }
                .padding(.top , 100)
            }
            .ignoresSafeArea()
        }
        
    }
}

#Preview {
    HomeView()
}
