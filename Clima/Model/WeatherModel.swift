//
//  WeatherModel.swift
//  Clima
//
//  Created by Evan Sun on 2024-09-03.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId:Int
    let cityName:String
    let temperature:Double
    var temperatureString:String {
        let string = String(format:"%.1f",temperature)
        return(string)
    }
    
    var conditionName:String {
        switch conditionId {
        case 200..<300:
            return("cloud.thunderstorm")
        case 300..<400:
            return("cloud.drizzle")
        case 500..<600:
            return("cloud.rain")
        case 600..<700:
            return("cloud.snow")
        case 700..<800:
            return("cloud.fog")
        case 800:
            return("sun.max")
        case 801...804:
            return("cloud.bolt")
        default:
            return("cloud")
        }
    }
}
