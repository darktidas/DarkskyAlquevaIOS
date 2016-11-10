//
//  File.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 16/10/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import Foundation

class StateControlData {
    
    
    var mapFilterStatus: [String: Bool]
    var mapConfiguration: [String: Bool]
    
    var xml: XmlReader!
    var internetConnection: Bool!
    var firstTime: Bool!
    
    init(mapFilterStatus: [String: Bool], mapConfiguration: [String: Bool]) {
        //self.xml = xml
        self.mapFilterStatus = mapFilterStatus
        self.mapConfiguration = mapConfiguration
    }
    
    func setInternetConnection(connection: Bool) {
        self.internetConnection = connection
    }
    
    func setFirstTime(first: Bool) {
        self.firstTime = first
    }
    
    func setXml(xml: XmlReader) {
        self.xml = xml
    }
}
