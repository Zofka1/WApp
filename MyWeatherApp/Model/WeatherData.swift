//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Zofka Jostakova on 26/07/2021.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    
}

struct Weather: Codable {
    let description: String
    let id: Int
}

