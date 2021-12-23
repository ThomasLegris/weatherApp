//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import MapKit
import Reusable
import RxSwift

// MARK: - Protocols
protocol MapAnnotationDelegate: class {
    // MARK: - Public Funcs
    /// Called when there are infos about current coordinate weather.
    ///
    /// - Parameters:
    ///     - cityName: name of the city
    ///     - weatherIcon: icon which describes weather
    ///     - temperature: current temperature value
    func shouldShowWeatherCityInfos(cityName: String,
                                    weatherIcon: UIImage,
                                    temperature: String)
}

/// Custom annotation object for map.
class MapAnnotation: NSObject, MKAnnotation {
    // MARK: - Public Properties
    var coordinate: CLLocationCoordinate2D

    // MARK: - Override Funcs
    override init() {
        self.coordinate = CLLocationCoordinate2D()
    }
}

/// Shows a custom annotation view.
final class MapAnnotationView: MKAnnotationView, NibOwnerLoadable {
    // MARK: - Outlets
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!

    // MARK: - Public Properties
    weak var delegate: MapAnnotationDelegate?

    // MARK: - Private Properties
    private let viewModel: CurrentWeatherViewModel = CurrentWeatherViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Override Funcs
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.commonInit()
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        self.commonInit()
    }
}

// MARK: - Private Funcs
private extension MapAnnotationView {
    /// Common init.
    func commonInit() {
        loadNibContent()
        viewModel.requestWeather(with: annotation?.coordinate)

        viewModel.weatherModel.subscribe { [weak self] model in
            self?.updateView(with: model)
        }.disposed(by: disposeBag)
    }

    /// Updates the view.
    ///
    /// - Parameters:
    ///     - model: common weather model
    func updateView(with model: CommonWeatherModel) {
        guard let temp = model.temperature,
              let icon = model.icon,
              let name = model.cityName else {
            return
        }

        iconImageView.image = icon
        tempLabel.text = "\(Int(temp))°"
        delegate?.shouldShowWeatherCityInfos(cityName: name,
                                             weatherIcon: icon,
                                             temperature: "\(Int(temp))°")
    }
}
