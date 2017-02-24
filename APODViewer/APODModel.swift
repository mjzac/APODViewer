//
//  APODModel.swift
//  APODViewer
//
//  Created by Melson Zacharias on 24/02/17.
//  Copyright © 2017 Perleybrook Labs LLC. All rights reserved.
//
import Argo
import Curry
import Runes

struct APODModel: Decodable {
    let title: String
    let date: Date
    let url: URL
    let hdURL: URL
    let explanation: String
    let mediaType: String?
    let copyright: String?
    let serviceVersion: String?
    
    /**
     Decode an object from JSON.
     
     This is the main entry point for Argo. This function declares how the
     conforming type should be decoded from JSON. Since this is a failable
     operation, we need to return a `Decoded` type from this function.
     
     - parameter json: The `JSON` representation of this object
     
     - returns: A decoded instance of the `DecodedType`
     */
    public static func decode(_ json: JSON) -> Decoded<APODModel> {
        let create = curry(APODModel.init)
        let tmp = create
            <^> json <| "title"
            <*> json <| "date"
            <*> json <| "url"
            <*> json <| "hdurl"
            <*> json <| "explanation"
            <*> json <|? "media_type"
        return tmp
            <*> json <|? "copyright"
            <*> json <|? "service_version"
    }
}

