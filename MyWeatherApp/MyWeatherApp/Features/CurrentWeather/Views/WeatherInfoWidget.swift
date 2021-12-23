//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import Reusable

/// View which displays a resume of the weather.e
final class WeatherInfoWidget: UIView, NibOwnerLoadable {
    // MARK: - Outlets
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var tempImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!

    // MARK: - Public Properties
    /// Returns a common model for city weather.
    var model: CommonWeatherModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Private Enums
    private enum Constants {
        static let format: String = "dd.MM.yyyy"
    }

    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitWeatherInfoWidget()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitWeatherInfoWidget()
    }
}

// MARK: - Private Funcs
private extension WeatherInfoWidget {
    /// Common init.
    func commonInitWeatherInfoWidget() {
        self.loadNibContent()

        temperatureLabel.textColor = ColorName.black60.color
        descriptionLabel.textColor = ColorName.black60.color

        dateLabel.textColor = ColorName.black60.color
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.format
        dateLabel.text = formatter.string(from: Date())
    }

    /// Updates the view.
    func updateView() {
        guard let model = model else {
            resetView()
            return
        }

        let temp = Int(model.temperature ?? 0.0)
        temperatureLabel.text = "\(temp)°"
        descriptionLabel.text = model.description
        weatherImageView.image = model.icon
    }

    /// Resets the view.
    func resetView() {
        temperatureLabel.text = L10n.dash
        descriptionLabel.text = L10n.dash
        weatherImageView.image = nil
    }
}
