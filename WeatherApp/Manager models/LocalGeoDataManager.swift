
import UIKit
import CoreLocation

class LocalGeoDataManager {
    
//MARK: Properties
    private var manager: WeatherAPIManager? {
        let manager = WeatherAPIManager()
        return manager
    }
    private var geocoder: CLGeocoder? {
        let geocoder = CLGeocoder()
        return geocoder
    }
    
//MARK: Methods
    private func callWeatherContent(by location: CLLocation, completion: @escaping (WeatherData?) -> Void) {
        manager?.callWeatherByLocation(location, completion: { (weatherData) in
            completion(weatherData)
        })
    }
    
    private func createGeoData(from weatherData: WeatherData?, and placemark: CLPlacemark?) -> GeoData? {
        let weather = weatherData
        let city = placemark?.locality
        let region = placemark?.administrativeArea
        let country = placemark?.country
        let locCoords = placemark?.location?.coordinate
        let coords = Coordinates(latitude: locCoords?.latitude, longitude: locCoords?.longitude)
        let place = PlaceData(city: city, region: region, country: country, coordinates: coords)
        let geoData = GeoData(weather: weather, place: place)
        return geoData
    }
    
    func callLocalGeoData(by location: CLLocation, completion: @escaping (GeoData?) -> Void) {
        geocoder?.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            let _location = placemarks?.first?.location ?? location
            self.callWeatherContent(by: _location) { (weatherData) in
                let placemark = placemarks?.first
                let geoData = self.createGeoData(from: weatherData, and: placemark)
                completion(geoData)
            }
        })
    }
    
}

