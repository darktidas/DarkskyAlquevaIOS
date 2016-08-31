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
    
    var data: NSData
    var xmlDoc: AEXMLDocument!
    
    var interestPoints: [Int: InterestPoint]!
    
    init(data: NSData){
        
        self.data = data
        
        do {
            self.xmlDoc = try AEXMLDocument(xmlData: data)
            
            // prints the same XML structure as original
            //print(xmlDoc.xmlString)
            
            // prints cats, dogs
            /*for child in xmlDoc.root.children {
                print(child.name)
            }*/
            
            readInterestPoints()
        }
        catch {
            print("\(error)")
        }
    }
    
    func readInterestPoints(){
        self.interestPoints = [:]
        //self.interestPoints[1] = InterestPoint(1,)
        
        //iterate over points
        //print(xmlDoc.root["pointsOfInterest"]["poi"])
        let points = xmlDoc.root["pointsOfInterest"][INTEREST_POINT_TEXT_NODE].all!
        for point in points{
            let id = Int(point.attributes[ID_TEXT_NODE]!)!
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
                print(spec.name)
                if spec.name == "name"{
                    name = spec.value
                }
                if spec.name == "location"{
                    latitude = Double(spec.children[0].value!)
                    longitude = Double(spec.children[1].value!)
                    //print(latitude.value!)
                    
                }
                if spec.name == "type"{
                    typeMap["astrophoto"] = toBool(spec.children[0].value!)
                    typeMap["landscape"] = toBool(spec.children[1].value!)
                    typeMap["observation"] = toBool(spec.children[2].value!)
                    //print(astrophoto.value!)
                    
                }
                if spec.name == "shortDescription"{
                    shortDescription = spec.value
                }
                if spec.name == "longDescription"{
                    longDescription = spec.value
                }
                if spec.name == "quality"{
                    quality["brightness"] = spec.children[0].value
                    quality["temperature"] = spec.children[1].value
                }
                if spec.name == "imagesURL"{
                    //print("\(id) -- \(spec.children.count)")
                    for i in 0...spec.children.count-1{
                        images.append(spec.children[i].value!) //error
                    }
                }
                if spec.name == "other"{
                    //print(other)
                    other = String(spec.value)
                }
            }
            print(id)
            print(name)
            print(latitude)
            print(longitude)
            print(typeMap)
            print(shortDescription)
            print(longDescription)
            print(quality)
            print(images)
            print(other)
            
            self.interestPoints[id] = InterestPoint(id:id, name:name, latitude:latitude, longitude:longitude, typeMap:typeMap, shortDescription:shortDescription, longDescription:longDescription, qualityParameters:quality, imagesURL:images, other:other)
        }
    }

    func toBool(value:String) -> Bool? {
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
    
    func read() {
        print("jaciara")
    }
}