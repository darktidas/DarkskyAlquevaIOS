//
//  XmlReader.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 08/08/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import Foundation

class XmlReader{
    
    var data: Data
    var xmlDoc: AEXMLDocument!
    
    var headerInfo: HeaderInfo!
    var general: String!
    var route: String!
    var interestPoints: [Int: InterestPoint]!
    var phenomenas: [Int: Phenomenon]!
    var constellations: [Int: Constellation]!
    var clothing: [Int: Clothing]!
    
    init(data: Data){
        
        self.data = data
        
        do {
            self.xmlDoc = try AEXMLDocument(xml: data)
            
            readHeaderInfo()
            readMain()
            readInterestPoints()
            readInformation()
            
        }
        catch {
            print("\(error)")
        }
    }
    
    func readHeaderInfo(){
        
        print("language = \(xmlDoc.root.attributes["language"]!)")
        guard let language = xmlDoc.root.attributes["language"] , xmlDoc.root.attributes["language"] != nil else{
            print("no language found")
            return
        }
        print("date = \(xmlDoc.root.attributes["date"]!)")
        guard let date = xmlDoc.root.attributes["date"] , xmlDoc.root.attributes["date"] != nil else{
            print("no date found")
            return
        }
        print("xmlSchemaVersion = \(xmlDoc.root.attributes["xmlSchemaVersion"]!)")
        guard let xmlSchemaVersion = xmlDoc.root.attributes["xmlSchemaVersion"] , xmlDoc.root.attributes["xmlSchemaVersion"] != nil else{
            print("no xmlSchemaVersion found")
            return
        }
        headerInfo = HeaderInfo(xmlVersion: String(xmlDoc.options.documentHeader.version), encoding: xmlDoc.options.documentHeader.encoding, language: language, date: date, schemaVersion: xmlSchemaVersion)
    }
    
    func readMain(){
        general = xmlDoc.root["main"]["general"].value
        route = xmlDoc.root["main"]["route"].value
    }
    
    func readInformation(){
        readPhenoms()
        readConstellations()
        readClothing()
    }
    
    func readPhenoms(){
        self.phenomenas = [:]
        let phenoms = xmlDoc.root["information"]["listOfPhenomenas"].children
        
        for phenom in phenoms{
            let id = Int(phenom.attributes["id"]!)!
            let name = phenom["name"].value!
            let period = phenom["period"].value!
            self.phenomenas[id] = Phenomenon(id: id, name: name, period: period)
        }
    }
    
    func readConstellations(){
        self.constellations = [:]
        
        let consts = xmlDoc.root["information"]["listOfConstellations"].children
        
        for const in consts{
            let id = Int(const.attributes["id"]!)!
            let name = const["name"].value!
            let period = const["period"].value!
            self.constellations[id] = Constellation(id: id, name: name, period: period)
        }
    }
    
    func readClothing(){
        self.clothing = [:]
        
        let cloths = xmlDoc.root["information"]["listOfClothings"].children
        
        for cloth in cloths{
            let id = Int(cloth.attributes["id"]!)!
            let type = cloth["type"].value!
            let period = cloth["period"].value!
            self.clothing[id] = Clothing(id: id, type: type, period: period)
        }
    }
    
    func readInterestPoints(){
        self.interestPoints = [:]
        
        let points = xmlDoc.root["pointsOfInterest"]["poi"].all!
        for point in points{
            let id = Int(point.attributes["id"]!)!
            var name: String!
            var latitude: Double!
            var longitude: Double!
            var typeMap = [String: Bool]()
            var shortDescription: String!
            var longDescription: String!
            var quality = [String: String]()
            var images = [String]()
            var other: String = ""
            
            let pointSpecifications = point.children
            
            for spec in pointSpecifications{
                if spec.name == "name"{
                    name = spec.value
                }
                if spec.name == "location"{
                    latitude = Double(spec.children[0].value!)
                    longitude = Double(spec.children[1].value!)
                    
                }
                if spec.name == "type"{
                    typeMap["astrophoto"] = toBool(spec.children[0].value!)
                    typeMap["landscape"] = toBool(spec.children[1].value!)
                    typeMap["observation"] = toBool(spec.children[2].value!)
                }
                if spec.name == "shortDescription"{
                    shortDescription = spec.value
                }
                if spec.name == "longDescription"{
                    longDescription = spec.value
                }
                if spec.name == "quality"{
                    if spec.children.count > 0{
                        if spec.children[0].value != nil {
                            quality["brightness"] = spec.children[0].value
                        }
                        if spec.children[1].value != nil {
                            quality["temperature"] = spec.children[1].value
                        }
                    }
                }
                if spec.name == "imagesURL"{
                    for i in 0...spec.children.count-1{
                        images.append(spec.children[i].value!)
                    }
                }
                if spec.name == "other"{
                    other = String(describing: spec.value)
                }
            }
            
            self.interestPoints[id] = InterestPoint(id:id, name:name, latitude:latitude, longitude:longitude, typeMap:typeMap, shortDescription:shortDescription, longDescription:longDescription, qualityParameters:quality, imagesURL:images, other:other)
        }
    }

    func toBool(_ value:String) -> Bool? {
        switch value {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func getInterestPoints() -> [Int: InterestPoint]{
        return self.interestPoints
    }
}
