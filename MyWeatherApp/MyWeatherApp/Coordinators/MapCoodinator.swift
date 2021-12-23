//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit

/// Coordinator which handles navigation for map.
final class MapCoodinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?

    func start() {
        let mapViewController = WeatherMapViewController.instantiate(coordinator: self)
        mapViewController.setupTabBar(title: L10n.map,
                                      image: Asset.icMapItemOff.image,
                                      selectedImage: Asset.icMapItemOn.image)
        self.navigationController = UINavigationController(rootViewController: mapViewController)
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Public Funcs
extension MapCoodinator {
    /// Displays details screen.
    ///
    /// - Parameters:
    ///     - cityName: name of the city
    func displayDetails(with cityName: String?) {
        let viewController = WeatherDetailsViewController.instantiate(coordinator: self,
                                                                      cityName: cityName)
        present(viewController)
    }
}
