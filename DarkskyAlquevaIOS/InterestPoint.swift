//
//  InterestPoint.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 20/08/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import Foundation

class InterestPoint{
    
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let typeMap: [String: Bool]
    let shortDescription: String
    let longDescription: String
    let qualityParameters: [String: String]
    let imagesURL: [String]
    let other: String
    
    init(id: Int, name: String, latitude: Double, longitude: Double, typeMap: [String: Bool], shortDescription: String, longDescription: String, qualityParameters: [String: String], imagesURL: [String], other: String){
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.typeMap = typeMap
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.qualityParameters = qualityParameters
        self.imagesURL = imagesURL
        self.other = other
    }
}