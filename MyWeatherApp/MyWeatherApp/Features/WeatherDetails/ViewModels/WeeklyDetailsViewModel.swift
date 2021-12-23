//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import SwiftyUserDefaults
import Reachability
import RxSwift

/// View Model which handle business logic of the daily weather view.
final class WeeklyDetailsViewModel {
    // MARK: - Public Properties
    var dailyDetailsModel = BehaviorSubject<WeeklyDetailsModel>(value: WeeklyDetailsModel(list: []))

    // MARK: - Private Properties
    private let disposeBag = DisposeBag()
}

// MARK: - Public Funcs
extension WeeklyDetailsViewModel {
    /// Calls the manager in order to get weekly weather information.
    ///
    /// - Parameters:
    ///     - city: name of the city
    func requestWeather(city: String) {
        WeatherApiManager.shared.cityWeeklyWeather(cityName: city)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { [weak self] result in
                    guard let model = result.weeklyDetailsModel else { return }

                    self?.dailyDetailsModel.onNext(model)
                }, onError: { _ in
                    return
                })
            .disposed(by: disposeBag)
    }
}
