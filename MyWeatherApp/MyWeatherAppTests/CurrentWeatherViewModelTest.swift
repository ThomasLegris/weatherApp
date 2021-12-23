//
//  CurrentWeatherViewModelModelTest.swift
//  MyWeatherAppTests
//
//  Created by Thomas LEGRIS on 14/03/2021.
//  Copyright © 2021 Thomas LEGRIS. All rights reserved.
//

import XCTest
import MapKit
@testable import MyWeatherApp
import RxSwift

/// Unit tests class used for `CurrentWeatherViewModel`.
class CurrentWeatherViewModelTest: XCTestCase {
    private let viewModel = CurrentWeatherViewModel()
    private var disposeBag = DisposeBag()

    /// Requests weather with nil city.
    func testRequestNilCity() {
        // GIVEN
        let cityName: String? = nil

        // WHEN
        viewModel.requestWeather(with: cityName)

        // THEN
        XCTAssertEqual(try viewModel.weatherError.value(), .unknownCity)
    }

    /// Requests weather with an empty city name.
    func testRequestEmptyCity() {
        // GIVEN
        let cityName: String = ""
        let viewModel = CurrentWeatherViewModel()

        // WHEN
        viewModel.requestWeather(with: cityName)

        // THEN
        XCTAssertEqual(try viewModel.weatherError.value(), .unknownCity)
    }

    /// Requests weather with a valid city name.
    func testRequestValidCity() {
        // GIVEN
        let cityName: String = "Rennes"
        let modelExpectation = XCTestExpectation(description: "Result from fetching city weather")

        // THEN
        viewModel.weatherModel.subscribe { model in
            // Verify not empty model from WS response.
            XCTAssertNotNil(model)
            modelExpectation.fulfill()
        }.disposed(by: disposeBag)

        // WHEN
        viewModel.requestWeather(with: cityName)

        wait(for: [modelExpectation], timeout: 5.0)
    }

    /// Requests weather with nil coordinate.
    func testRequestNilCoordinate() {
        // GIVEN
        let coordinate: CLLocationCoordinate2D? = nil

        // WHEN
        viewModel.requestWeather(with: coordinate)

        // THEN
        XCTAssertEqual(try viewModel.weatherError.value(), .noInfo)
    }

    /// Requests weather with nil coordinate.
    func testRequestNotNilCoordinate() {
        // GIVEN
        /// Example of coordinate from Rennes.
        let coordinate: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: 48.117266,
                                                                         longitude: -1.6777926)
        let modelExpectation = XCTestExpectation(description: "Result from fetching coordinate weather")

        // THEN
        viewModel.weatherModel.subscribe { model in
            // Verify not empty model from WS response.
            XCTAssertNotNil(model)
            // The WS should return the name of the city at the given coordinate.
            XCTAssertEqual(model.element?.cityName, "Rennes")
            modelExpectation.fulfill()
        }.disposed(by: disposeBag)

        // WHEN
        viewModel.requestWeather(with: coordinate)

        wait(for: [modelExpectation], timeout: 10.0)
    }
}
