//
//  MyWeatherParserTest.swift
//  MyWeatherApp
//
//  Created by Thomas LEGRIS on 13/03/2021.
//  Copyright © 2021 Thomas LEGRIS. All rights reserved.
//

import XCTest
@testable import MyWeatherApp

/// Unit tests class used for `MyWeatherPaser`.
class MyWeatherParserTest: XCTestCase {
    /// Parse an invalid WS response into the model.
    func testBuildWeatherModelInvalidResponse() {
        // GIVEN
        let main = MainField(temp: 0.0, pressure: 0.0, humidity: 0.0, tempMin: 0.0, tempMax: 0.0)
        let response = LocalWeatherResponse(weather: nil, main: main, name: "")

        // WHEN
        // Default model exepected when there is an error.
        let expectedModel = CommonWeatherModel(temperature: 0.0,
                                               icon: Asset.icSun.image,
                                               description: "",
                                               cityName: "")
        // THEN
        XCTAssertEqual(response.commonWeatherModel, expectedModel)
    }

    /// Parse a valid WS response into the model.
    /// Example of a snowy day at Rennes.
    func testBuildWeatherModelSuccessResponse() {
        // GIVEN
        let main = MainField(temp: 10.0, pressure: 5.0, humidity: 10.0, tempMin: 7.0, tempMax: 14.0)
        let weather: [WeatherField]? = [WeatherField(identifier: 600, main: "Snow", icon: "13d")]
        let response = LocalWeatherResponse(weather: weather, main: main, name: "Rennes")

        // WHEN
        let expectedModel = CommonWeatherModel(temperature: 10.0,
                                               icon: Asset.icSnow.image,
                                               description: "Snow",
                                               cityName: "Rennes")
        // THEN
        XCTAssertEqual(response.commonWeatherModel, expectedModel)
    }
}
