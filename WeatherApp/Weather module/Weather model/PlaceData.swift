
import Foundation
import CoreLocation

struct PlaceData {
    var city: String?
    var region: String?
    var country: String?
    var coordinates: Coordinates?
}

struct Coordinates: Codable {
    var latitude: Double?
    var longitude: Double?
}
