//
//  WidgetApiManager.swift
//  MyWeatherWidgetExtension
//
//  Created by Thomas Legris on 10/03/2023.
//  Copyright © 2023 Thomas LEGRIS. All rights reserved.
//

import Foundation
import WidgetKit
import SwiftyUserDefaults

/// Manager which handles methods relative to Weather API.
final class WidgetApiManager {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    /// Returns the Open Weather Map API Key.
    private var apiKey: String {
        // Find Api plist file.
        guard let filePath = Bundle.main.path(forResource: "OpenWM-info", ofType: "plist") else {
            fatalError("No API plist file")
        }
        
        // Find the Api key.
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "api_key") as? String else {
            fatalError("No api_key for OWMap")
        }
        
        return value
    }
    
    // MARK: - Init
    init() { }
}

extension WidgetApiManager {
    /// Provides common constants.
    enum Constants {
        static let baseURL: String = "https://api.openweathermap.org/data/2.5/"
        static let tempUnit: String = "metric"
        static let cityParam: String = "q"
        static let unitsParam: String = "units"
        static let keyParam: String = "APPID"
    }
    
    func requestDailyWeather(completion: @escaping (_ model: MyWeatherWidgetEntry?, _ error: Error?) -> Void) {
        // Get last App searched city to update its weather.
        let city = UserDefaults(suiteName: "group.weatherapp.MyWeatherApp.contents")?.string(forKey: "key_widgetCityName")
        
        let params: [String: String] = [Constants.cityParam: city ?? "Rennes", // TODO: Get from user default
                                        Constants.unitsParam: Constants.tempUnit,
                                        Constants.keyParam: "5eb5a01a0f1829cf671e3fd56c7ccdc6"]
        
        
        self.sendRequest(endPoint: "weather",
                         params: params,
                         completion: { model, error in
           completion(model, error)
        })
    }
   
}

private extension WidgetApiManager {
    /// Handles the Data response with multiple verification and returns the response in a Data object if it's correct.
    ///
    /// - Parameters:
    ///    - endPoint: end point target
    ///    - params: json dict of query
    ///    - completion: callback with the server response
    func sendRequest(endPoint: String,
                     params: [String: String] = [:],
                     completion: @escaping (_ model: MyWeatherWidgetEntry?, _ error: Error?) -> Void) {
        
        guard let url = buildURLWithComponents(endPoint: endPoint, params: params) else {
            completion(nil, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.handleResponse(data: data,
                                response: response,
                                error: error,
                                completion: completion)
        }.resume()
    }
    
    /// Handle the response with several checks.
    ///
    /// - Parameters:
    ///    - data: Data from the server
    ///    - response: Response from the server
    ///    - error: Error from the server
    ///    - completion: Callback with the server response which provides a weather model and an error
    func handleResponse(data: Data?,
                        response: URLResponse?,
                        error: Error?,
                        completion: @escaping (_ model: MyWeatherWidgetEntry?, _ error: Error?) -> Void) {
        guard error == nil else {
            completion(nil, error)
            return
        }
        
        guard let responseData = data else {
            completion(nil, nil)
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let jsonResponse = try decoder.decode(LocalWeatherResponse.self, from: responseData)
            
            guard let weather = jsonResponse.weather?.first else {
                completion(nil, nil)
                return
            }
            
            let entry = MyWeatherWidgetEntry(date: Date(),
                                             city: jsonResponse.name,
                                             temperature: jsonResponse.main.temp,
                                             description: weather.main,
                                             iconName: weather.icon)
            completion(entry, nil)
        } catch let decodeError {
            print(decodeError)
            completion(nil, decodeError)
        }
    }
    
    /// Create an url with url components.
    ///
    /// - Parameters:
    ///    - endPoint: end point target
    ///    - params: json dict of query
    /// - Returns: The entire builded url.
    func buildURLWithComponents(endPoint: String, params: [String: String] = [:]) -> URL? {
        var components = URLComponents(string: Constants.baseURL + endPoint)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        
        return components?.url
    }
}
