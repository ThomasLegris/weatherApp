//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import RealmSwift
import Foundation

/// Stores a Favorite city object for data base.
class FavoriteCity: Object {
    /// Name of the city to add in favorite table.
    @objc dynamic var cityName: String = ""
}
