//
//  NasaAPI.swift
//  APODViewer
//
//  Created by Melson Zacharias on 24/02/17.
//  Copyright © 2017 Perleybrook Labs LLC. All rights reserved.
//
import Moya

enum NasaAPI {
    
    case apod(apiKey: String, date: Date, hd: Bool)
}

extension NasaAPI : TargetType {
    var baseURL: URL { return URL(string: "https://api.nasa.gov")! }
    var path: String {
        switch self {
        case .apod(_, _, _):
            return "/planetary/apod"
        }
    }
    var method: Moya.Method {
        switch self {
        case .apod:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .apod(let apiKey, let date, let hd):
            let date = date.getAPODDate() ?? Date().getAPODDate()!
            return ["api_key": apiKey, "date": date, "hd": "\(hd)".capitalized]
        }
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .apod:
            return URLEncoding.default
        }
    }
    var task: Task {
        switch self {
        case .apod:
            return .request
        }
    }
    var sampleData: Data {
        switch self {
        case .apod(_, _, _):
            let result = [
                "copyright": "Robert Gendler",
                "date": "2017-02-24",
                "explanation": "Far beyond the local group of galaxies lies NGC 3621, some 22 million light-years away. Found in the multi-headed southern constellation Hydra, the winding spiral arms of this gorgeous island universe are loaded with luminous blue star clusters, pinkish starforming regions, and dark dust lanes. Still, for astronomers NGC 3621 has not been just another pretty face-on spiral galaxy. Some of its brighter stars have been used as standard candles to establish important estimates of extragalactic distances and the scale of the Universe. This beautiful image of NGC 3621, is a composite of space- and ground-based telescope data. It traces the loose spiral arms far from the galaxy's brighter central regions for some 100,000 light-years. Spiky foreground stars in our own Milky Way Galaxy and even more distant background galaxies are scattered across the colorful skyscape.",
                "hdurl": "http://apod.nasa.gov/apod/image/1702/NGC3621-HST-ESO-gendlerL.jpg",
                "media_type": "image",
                "service_version": "v1",
                "title": "NGC 3621: Far Beyond the Local Group",
                "url": "http://apod.nasa.gov/apod/image/1702/NGC3621-HST-ESO-gendler1024.jpg"
                ].map { "\($0): \($1)"}.joined(separator: ",")
            return "{ \(result) }".utf8Encoded
            
        }
    }
    
    public static func getAPODConfig(apiKey: String = Secrets.NasaAPIKey, date: Date = Date(), hd: Bool = false) -> NasaAPI {
        return NasaAPI.apod(apiKey: apiKey, date: date, hd: hd)
    }
}
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
