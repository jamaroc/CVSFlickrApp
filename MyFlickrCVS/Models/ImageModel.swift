//
//  ImageModel.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import Foundation

struct ImageModel: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let author: String
    let published: Date
    let imageURL: URL
}

