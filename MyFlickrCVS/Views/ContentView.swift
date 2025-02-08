//
//  ContentView.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ImageSearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarView(viewmodel: viewModel)
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ImageGridView(images: viewModel.images)
                }
                Spacer()
            }
            .navigationBarTitle("Flickr Pic Search")
        }
    }
}

#Preview {
    ContentView()
}
