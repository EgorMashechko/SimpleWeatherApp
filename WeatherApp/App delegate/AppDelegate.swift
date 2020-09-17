import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSPlacesClient.provideAPIKey("AIzaSyA7a9OOtHJ9Ol_yodYPZzs8OO9WYS9vD9Y")
        
//        let storageManager = StorageManager.shared
//
//        if storageManager.containsCoordinates {
//            if let coordinates = storageManager.storedCoordinates {
//                let geoDataFinder = GeoDataFinder()
//                geoDataFinder.delegate = self
//                geoDataFinder.findBySpecified(coordinates: coordinates)
//            }
//        } else {
//            let storyboard = UIStoryboard(name: "Finder", bundle: Bundle.main)
//            let vc = storyboard.instantiateInitialViewController() as! FinderViewController
//            UIApplication.shared.windows.first?.rootViewController = vc
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
//        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available (iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available (iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}


//extension AppDelegate: GeoDataFinderDelegate {
//    func didGeoDataFinded(with geoData: GeoData?) {
//        let storyboard = UIStoryboard(name: "Weather", bundle: Bundle.main)
//        DispatchQueue.main.async {
//                    let vc = storyboard.instantiateInitialViewController() as! WeatherViewController
//            vc.geoData = geoData
//            UIApplication.shared.windows.first?.rootViewController = vc
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
//        }
//
//    }
//
//}

