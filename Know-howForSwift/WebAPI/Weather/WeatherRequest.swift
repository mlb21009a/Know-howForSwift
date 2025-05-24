//
//  WeatherRequest.swift
//  Know-howForSwift
//
//  Created by R on 2025/05/23.
//

class WeatherRequest: Request {
    typealias Response = WeatherResponse

    var url = "https://weather.tsukumijima.net/api/forecast"

    var params =  ["city": "110010"]

    var method: String = "GET"


}
