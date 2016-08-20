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
    let imagesURL: [String]
    let typeMap: [String: Bool]
    let latitude: Double
    let longitude: Double
    let shortDescription: String
    let longDescription: String
    let qualityParameters: [String: String]
    let other: String
    
    init(id: Int, name: String, imagesURL: [String], typeMap: [String: Bool], latitude: Double,
         longitude: Double, shortDescription: String, longDescription: String, qualityParameters: [String: String], other: String){
        self.id = id
        self.name = name
        self.imagesURL = imagesURL
        self.typeMap = typeMap
        self.latitude = latitude
        self.longitude = longitude
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.qualityParameters = qualityParameters
        self.other = other
    }
}