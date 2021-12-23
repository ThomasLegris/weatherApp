//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import Reusable

/// Displays a cell which give weather of a selected day.
final class WeeklyDetailsCollectionViewCell: UICollectionViewCell, NibReusable {
    // MARK: - Outlets
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!

    // MARK: - Private Enums
    private enum Constants {
        static let format: String = "E d"
    }

    // MARK: - Override Funcs
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        dateLabel.text = nil
        weatherImageView.image = nil
        tempLabel.text = nil
    }

    // MARK: - Public Funcs
    /// Sets up table view cell.
    ///
    /// - Parameters:
    ///     - date: current date
    ///     - icon: daily icon to display
    ///     - temperature: daily temperature
    func setupCell(date: Int,
                   icon: UIImage?,
                   temperature: Int) {
        weatherImageView.image = icon
        tempLabel.text = "\(temperature)°"
        let currentDate = Date(timeIntervalSince1970: TimeInterval(date))

        let formatter = DateFormatter()
        formatter.dateFormat = Constants.format
        dateLabel.text = formatter.string(from: currentDate)
    }
}
