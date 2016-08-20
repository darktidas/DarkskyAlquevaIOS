//
//  XmlReader.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 08/08/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import Foundation

class XmlReader{
    
    let GENERAL_TEXT_NODE = "general"
    let ROUTE_TEXT_NODE = "route"
    let LANGUAGE_TEXT_NODE = "language"
    let DATE_TEXT_NODE = "date"
    let VERSION_TEXT_NODE = "version"
    let SCHEMA_VERSION_TEXT_NODE = "xmlSchemaVersion"
    let MAIN_TEXT_NODE = "main"
    let CLOTHING_TEXT_NODE = "clothing"
    let ID_TEXT_NODE = "id"
    let TYPE_TEXT_NODE = "type"
    let PERIOD_TEXT_NODE = "period"
    let PHENOMENA_TEXT_NODE = "phenomena"
    let NAME_TEXT_NODE = "name"
    let CONSTELLATION_TEXT_NODE = "constellation"
    let INTEREST_POINT_TEXT_NODE = "poi"
    let LOCATION_TEXT_NODE = "location"
    let QUALITY_TEXT_NODE = "quality"
    let SHORT_DESCRIPTION_TEXT_NODE = "shortDescription"
    let LONG_DESCRIPTION_TEXT_NODE = "longDescription"
    let OTHER_TEXT_NODE = "other"
    let IMG_TEXT_NODE = "imagesURL"
    
    var path: String
    
    init(path: String){
        self.path = path
    }
    
    func read() {
        print("jaciara")
    }
}