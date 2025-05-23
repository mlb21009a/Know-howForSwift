//
//  WeatherResponse.swift
//  Know-howForSwift
//
//  Created by R on 2025/05/23.
//

struct WeatherResponse: Decodable {
    struct Description: Decodable {
        let bodyText: String
    }
    let title: String
    let description: Description
    let forecasts: [Forecast]

    struct Forecast: Decodable {
        let dateLabel: String
        let telop: String
    }
}

