//
//  Phenomenon.swift
//  DarkskyAlquevaIOS
//
//  Created by tiago  on 04/09/16.
//  Copyright © 2016 tiago . All rights reserved.
//

import Foundation

class Phenomenon{
    let id: Int
    let name: String
    let period: String
    
    init(id: Int, name: String, period: String){
        self.id = id
        self.name = name
        self.period = period
    }
}