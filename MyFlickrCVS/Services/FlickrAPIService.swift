//
//  FlickrAPIService.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import Foundation
import Combine

class FlickrAPIService {
    static func fetchImages(urlString: String) -> AnyPublisher<[ImageModel], Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }

                guard 200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.init(rawValue: httpResponse.statusCode))
                }

                return data
            }
            .decode(type: FlickrResponse.self, decoder: JSONDecoder())
            .map { $0.items.map { $0.toImageModel() } }
            .eraseToAnyPublisher()
    }
}


struct FlickrResponse: Codable {
    let items: [FlickrItem]
}

struct FlickrItem: Codable {
    let title: String
    let description: String
    let author: String
    let published: String
    let media: [String: String]

    func toImageModel() -> ImageModel {
        return ImageModel(
            title: title,
            description: description,
            author: author,
            published: DateFormatter.flickr.date(from: published) ?? Date(),
            imageURL: URL(string: media["m"]!)!
        )
    }
}
