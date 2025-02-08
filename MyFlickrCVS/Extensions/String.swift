//
//  String.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import Foundation
import SwiftUI

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? self
    }
}
