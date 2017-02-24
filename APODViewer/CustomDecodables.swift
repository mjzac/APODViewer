//
//  CustomDecodables.swift
//  APODViewer
//
//  Created by Melson Zacharias on 24/02/17.
//  Copyright © 2017 Perleybrook Labs LLC. All rights reserved.
//

import Foundation
import Argo

extension Date: Decodable {
    public typealias DecodedType = Date
    static func parseAPODDate(string: String, format: String = "yyyy-MM-dd") -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.date(from: string)
    }
    func getAPODDate(format: String = "yyyy-MM-dd") -> String? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: self)
    }
    public static func decode(_ json: JSON) -> Decoded<Date> {
        switch json {
        case .string(let jsonString):
            guard let result = Date.parseAPODDate(string: jsonString).map(Argo.pure) else { return .typeMismatch(expected: "yyyy-MM-dd Date", actual: json) }
            return result
        default:
            return .typeMismatch(expected: "yyyy-MM-dd Date", actual: json)
        }
    }
}

extension URL: Decodable {
    public typealias DecodedType = URL
    public static func decode(_ json: JSON) -> Decoded<URL> {
        switch json {
        case .string(let urlString):
            guard let tUrl = URL(string: urlString).map(Argo.pure) else { return .typeMismatch(expected: "Absolute URL String", actual: json) }
            return tUrl
            
        default:
            return .typeMismatch(expected: "Absolute URL String", actual: json)
        }
    }
}
