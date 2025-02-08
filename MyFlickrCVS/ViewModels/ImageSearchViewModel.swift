//
//  ImageSearchViewModel.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import SwiftUI
import Combine

import SwiftUI
import Combine

class ImageSearchViewModel: ObservableObject {
    @Published var searchText = "" {
        didSet {
            searchImages()
        }
    }
    @Published var images: [ImageModel] = []
    @Published var isLoading = false

    private var cancellable: AnyCancellable?
    private let apiService: FlickrAPIService.Type

    init(apiService: FlickrAPIService.Type = FlickrAPIService.self) {
        self.apiService = apiService
    }

    private func searchImages() {
        guard !searchText.isEmpty else { return }
        isLoading = true
        let searchString = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(searchString)"

        cancellable = apiService.fetchImages(urlString: urlString)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Error fetching images: \(error)")
                }
            }, receiveValue: { [weak self] images in
                self?.images = images
            })
    }
}
