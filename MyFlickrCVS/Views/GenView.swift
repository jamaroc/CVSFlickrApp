//
//  AsyncImageView.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import SwiftUI
import Combine

import Kingfisher

struct AsyncImageView: View {
    let url: URL

        var body: some View {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
        }
}
// SearchBarView
struct SearchBarView: View {
    @ObservedObject var viewmodel: ImageSearchViewModel
    
    var body: some View {
        TextField("Search...", text: $viewmodel.searchText)
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
    }
}

// ImageGridView
struct ImageGridView: View {
    var images: [ImageModel]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(images) { image in
                    NavigationLink(destination: ImageDetailView(image: image)) {
                        AsyncImageView(url: image.imageURL)
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 100)
                    }
                }
            }
            .padding()
        }
    }
}


// Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(images: [
            ImageModel(title: "Test", description: "Desc", author: "1", published: Date(), imageURL: URL(string: "https://via.placeholder.com/150")!),
            ImageModel(title: "Test2", description: "Desc2", author: "JAC2", published: Date(), imageURL: URL(string: "https://via.placeholder.com/150")!)
        ])
    }
}

