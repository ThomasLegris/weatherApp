//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import Reusable
import RxSwift

/// Displays a city weather cell in the favorite cities table view.
final class FavoriteCityCell: UITableViewCell, NibReusable {
    // MARK: - Outlets
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionIcon: UIImageView!
    @IBOutlet private weak var bgView: UIView!

    // MARK: - Private Properties
    private var city: FavoriteCity?
    private let viewModel: CurrentWeatherViewModel = CurrentWeatherViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Private Enums
    private enum Constants {
        static let cornerRadius: CGFloat = 6.0
        static let borderWidth: CGFloat = 1.0
    }

    // MARK: - Override Funcs
    override func awakeFromNib() {
        super.awakeFromNib()

        initView()
    }

    // MARK: - Public Funcs
    /// Configures the cell.
    ///
    /// - Parameters:
    ///     - city: current city registered in favorite
    func configureCell(city: FavoriteCity) {
        self.city = city
        setupViewModel()
    }
}

// MARK: - Private Funcs
private extension FavoriteCityCell {
    /// Inits the view.
    func initView() {
        resetView()
        bgView.cornerRadiusedWith(backgroundColor: ColorName.white20,
                                  borderColor: ColorName.white50.color,
                                  radius: Constants.cornerRadius,
                                  borderWidth: Constants.borderWidth)
    }

    /// Sets up the view model.
    func setupViewModel() {
        viewModel.requestWeather(with: city?.cityName)
        viewModel.weatherModel.subscribe {[weak self] _ in
            self?.updateView()
        }.disposed(by: disposeBag)

        updateView()
    }

    /// Resets the view.
    func resetView() {
        temperatureLabel.text = L10n.dash
        cityLabel.text = L10n.dash
        weatherDescriptionLabel.text = L10n.dash
        weatherDescriptionIcon.image = nil
    }

    /// Update view according to weather request answer.
    func updateView() {

        guard let model = try? viewModel.weatherModel.value(),
              let temp = model.temperature,
              let name = city?.cityName,
              let description = model.description else {
            return
        }

        temperatureLabel.text = "\(Int(temp))°"
        cityLabel.text = name
        weatherDescriptionLabel.text = description
        weatherDescriptionIcon.image = model.icon
    }
}
