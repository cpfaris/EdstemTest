//
//  DaysForecastModel.swift
//  EdstemTest
//
//  Created by FARIS CP on 09/12/24.
//

import Foundation
// MARK: - DaysForecast
struct DaysForecast: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [ForcastList]?
    let city: City?
}
//
// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}
//
////// MARK: - Coord
////struct Coord: Codable {
////    let lat, lon: Double?
////}
//
// MARK: - List
struct ForcastList: Codable {
    let dt: Int?
    let main: Main?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let sys: Sys?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
    }
}

//// MARK: - Clouds
//struct Clouds: Codable {
//    let all: Int?
//}

// MARK: - Main
//struct Main: Codable {
//    let temp, feelsLike, tempMin, tempMax: Double?
//    let pressure, seaLevel, grndLevel, humidity: Int?
  //  let tempKf: Double?

//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case pressure
//        case seaLevel = "sea_level"
//        case grndLevel = "grnd_level"
//        case humidity
//        case tempKf = "temp_kf"
//    }
//}

//// MARK: - Sys
//struct Sys: Codable {
//    let pod: String?
//}
//
//// MARK: - Weather
//struct Weather: Codable {
//    let id: Int?
//    let main, description, icon: String?
//}
//
//// MARK: - Wind
//struct Wind: Codable {
//    let speed: Double?
//    let deg: Int?
//    let gust: Double?
//}
