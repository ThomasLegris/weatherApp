//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import Reusable
import RxSwift

/// Displays a daily weather details.
final class DailyDetailsView: UIView, NibOwnerLoadable {
    // MARK: - Outlets
    @IBOutlet private weak var windTitleLabel: UILabel!
    @IBOutlet private weak var windValueLabel: UILabel!
    @IBOutlet private weak var humidityTitleLabel: UILabel!
    @IBOutlet private weak var humidityValueLabel: UILabel!
    @IBOutlet private weak var sunriseTitleLabel: UILabel!
    @IBOutlet private weak var sunriseValueLabel: UILabel!
    @IBOutlet private weak var sunsetTitleLabel: UILabel!
    @IBOutlet private weak var sunsetValueLabel: UILabel!
    @IBOutlet private weak var dailyTitleLabel: UILabel!
    @IBOutlet private weak var dailyTitleView: UIView!

    // MARK: - Public Properties
    var cityName: String? {
        didSet {
            guard let city = cityName else { return }

            viewModel.requestWeather(city: city)
        }
    }

    // MARK: - Private Properties
    private let viewModel: DailyDetailsViewModel = DailyDetailsViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Override Funcs
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitDailyDetailsView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitDailyDetailsView()
    }
}

// MARK: - Private Funcs
private extension DailyDetailsView {
    /// Common init.
    func commonInitDailyDetailsView() {
        self.loadNibContent()

        dailyTitleLabel.text = L10n.dailyDetails
        dailyTitleView.cornerRadiusedWith(backgroundColor: .white20, radius: 9.0)
        humidityTitleLabel.text = L10n.humidity
        windTitleLabel.text = L10n.wind
        sunsetTitleLabel.text = L10n.sunrise
        sunriseTitleLabel.text = L10n.sunrise

        setupViewModel()
    }

    /// Sets up view model.
    func setupViewModel() {
        viewModel.dailyDetailsModel.subscribe { [weak self] model in
            DispatchQueue.main.async {
                self?.updateView(with: model)
            }
        }.disposed(by: disposeBag)
    }

    /// Updates view with view model value response.
    ///
    /// - Parameters:
    ///     - model: Daily weather details data
    func updateView(with model: DailyDetailsModel) {
        humidityValueLabel.text = (model.humidity ?? L10n.dash) + L10n.percentUnit
        windValueLabel.text = (model.wind ?? L10n.dash) + L10n.speedUnit
        sunsetValueLabel.text = model.sunset
        sunriseValueLabel.text = model.sunrise
    }
}
