//
//  WeatherData.swift
//  Clima
//
//  Created by Evan Sun on 2024-08-09.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable { //A type that can decode itself from an external representation.
    let name:String
    let main:Main
    let weather:[Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather:Codable {
    let id:Int
}
