import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storageManager = StorageManager.shared
        
        if storageManager.containsCoordinates {
            if let coordinates = storageManager.storedCoordinates {
                let geoDataFinder = GeoDataFinder()
                geoDataFinder.delegate = self
                geoDataFinder.findBySpecified(coordinates: coordinates)
            }
        } else {
            let storyboard = UIStoryboard(name: "Finder", bundle: Bundle.main)
            let vc = storyboard.instantiateInitialViewController() as! FinderViewController
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}

extension ViewController: GeoDataFinderDelegate {
    func didGeoDataFinded(with geoData: GeoData?) {
        let storyboard = UIStoryboard(name: "Weather", bundle: Bundle.main)
        DispatchQueue.main.async {
            let vc = storyboard.instantiateInitialViewController() as! WeatherViewController
            vc.geoData = geoData
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}






