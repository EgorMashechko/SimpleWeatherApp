
import Foundation
import CoreLocation
import GooglePlaces

//MARK: Delegate protocol
protocol GeoDataFinderDelegate: AnyObject {
    func didGeoDataFinded(with geoData: GeoData?)
}

class GeoDataFinder: NSObject {
    
//MARK: Properties
    //targetVC uses for displaying GMSAutocompleteViewController and App location service status alert when user choose find by city or find by current location
    weak var targetVC: UIViewController?
    weak var delegate: GeoDataFinderDelegate?
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    private var geoDataManager: LocalGeoDataManager? {
        let manager = LocalGeoDataManager()
        return manager
    }
    private var completerVC: GMSAutocompleteViewController? {
        let completer = createGMSAutocompleteVC()
        completer.delegate = self
        return completer
    }
    
//MARK: Initialization
    //use this init when you need to display a city autocomplete finder, and App location service status alert
    convenience init(target: UIViewController) {
        self.init()
        targetVC = target
    }
    
    //use this init when you doesn't need to display city autocomplete finder, and App location service status alert (for example for use method findBySpecified(: Coordinates))
    override init() {
        super.init()
    }
    
//MARK: Methods
    func findByCity() {
        let destinationCompleterVC = completerVC
        targetVC?.present(destinationCompleterVC!, animated: true, completion: nil)
    }
    
    func findByCurrentLocation() {
        locationManager.requestLocation()
    }
    
    func findBySpecified(coordinates: Coordinates) {
        if let lat = coordinates.latitude, let lon = coordinates.longitude {
            if let latitude = CLLocationDegrees(exactly: lat), let longitude = CLLocationDegrees(exactly: lon) {
                let location = CLLocation(latitude: latitude, longitude: longitude)
                geoDataManager?.callLocalGeoData(by: location, completion: { (geoData) in
                    self.delegate?.didGeoDataFinded(with: geoData)
                })
            }
        }
    }
    
    private func createGMSAutocompleteVC() -> GMSAutocompleteViewController {
        let controller = GMSAutocompleteViewController()
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        controller.autocompleteFilter = filter
        controller.modalPresentationStyle = .currentContext
        return controller
    }
    
    private func createAlert(withMessage message: String?) -> UIAlertController? {
        let action = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(action)
        return alert
    }
}

//MARK: Delegate methods
extension GeoDataFinder: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinates = locations.last?.coordinate {
            let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
            geoDataManager?.callLocalGeoData(by: location, completion: { (geoData) in
                self.delegate?.didGeoDataFinded(with: geoData)
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        /* обработать ошибки */
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            let message = NSLocalizedString("alert_restricted", comment: "")
            if let alert = createAlert(withMessage: message) {
                targetVC?.present(alert, animated: true, completion: nil)
            }
            return
        case .denied:
            let message = NSLocalizedString("alert_denied", comment: "")
            if let alert = createAlert(withMessage: message) {
                targetVC?.present(alert, animated: true, completion: nil)
            }
            return
        default:
            return
        }
        
    }
}

extension GeoDataFinder: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        viewController.dismiss(animated: true, completion: nil)
        let coordinate = place.coordinate
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoDataManager?.callLocalGeoData(by: location, completion: { (geoData) in
            self.delegate?.didGeoDataFinded(with: geoData)
        })
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        /* обработать ошибку автокомплита*/
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
