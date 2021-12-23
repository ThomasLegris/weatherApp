//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import SwiftyUserDefaults
import Reachability
import RxSwift

/// View Model which handles business logic of the daily weather view.
final class DailyDetailsViewModel {
    // MARK: - Public Properties
    var dailyDetailsModel = BehaviorSubject<DailyDetailsModel>(value: DailyDetailsModel(humidity: "",
                                                                                        wind: "",
                                                                                        sunset: "",
                                                                                        sunrise: ""))

    // MARK: - Private Properties
    private let disposeBag = DisposeBag()
}

// MARK: - Public Funcs
extension DailyDetailsViewModel {
    /// Calls the manager in order to get daily weather information.
    ///
    /// - Parameters:
    ///     - city: name of the city
    func requestWeather(city: String) {
        WeatherApiManager.shared.cityDetailsWeather(cityName: city)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] result in
                    guard let model = result.dailyDetailsModel else { return }

                    self?.dailyDetailsModel.onNext(model)
                }, onError: { _ in
                    return
                })
            .disposed(by: disposeBag)
    }
}
