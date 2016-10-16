//
//  File.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 16/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import Foundation

class StateControlData {
    
    let xml: XmlReader!
    var mapFilterStatus: [String: Bool]
    var mapConfiguration: [String: Bool]
    
    init(xml: XmlReader, mapFilterStatus: [String: Bool], mapConfiguration: [String: Bool]) {
        self.xml = xml
        self.mapFilterStatus = mapFilterStatus
        self.mapConfiguration = mapConfiguration
    }
}
