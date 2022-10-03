//
//  CurrentWeatherData.swift
//  weatherAPI
//
//  Created by Hung-Ming Chen on 2022/9/1.
//

import Foundation

struct CurrentWeatherData: Decodable {
    var name: String
    var id: Int
    var dt: TimeInterval
    
    var coord: Coord
    var main: Main
    var weather: [Weather]
}

struct Coord: Decodable {
    var lon: Double
    var lat: Double
}

struct Main: Decodable {
    var temp: Double
    var humidity: Int
    var temp_min: Double
    var temp_max: Double
}

struct Weather: Decodable {
    var icon: String
    var main: String
    var description: String
}
