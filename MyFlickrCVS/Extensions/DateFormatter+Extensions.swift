//
//  DateFormatter+Extensions.swift
//  Flickr_CVS
//
//  Created by Alexander Adegbenro on 7/3/24.
//

import Foundation

extension DateFormatter {
    static let flickr: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}

