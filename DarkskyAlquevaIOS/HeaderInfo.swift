//
//  HeaderInfo.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 04/09/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import Foundation

class HeaderInfo {
    
    let xmlVersion: String
    let encoding: String
    let language: String
    let date: String
    let schemaVersion: String
    
    init(xmlVersion: String, encoding: String, language: String, date: String, schemaVersion: String){
        self.xmlVersion = xmlVersion
        self.encoding = encoding
        self.language = language
        self.date = date
        self.schemaVersion = schemaVersion
    }
}