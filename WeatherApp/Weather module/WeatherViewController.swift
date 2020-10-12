
import UIKit

class WeatherViewController: UIViewController {
    
//MARK: Properties
    var geoData: GeoData?
    
//MARK: Lifecycle methods
    override func loadView() {
        let contentView = WeatherContentView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contentView = self.view as? WeatherContentView {
            contentView.geoData = geoData
            contentView.delegate = self
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        let storageManager = StorageManager.shared
        storageManager.saveCoordinates(from: geoData)
    }
}

//MARK: WeatherContentViewDelegate
extension WeatherViewController: WeatherContentViewDelegate {
    func weatherContentView(_ view: WeatherContentView, didMenuButtonTap sender: UIButton) {
        let storyboard = UIStoryboard(name: "Finder", bundle: Bundle.main)
        if let destinationVC = storyboard.instantiateInitialViewController() as? FinderViewController {
            destinationVC.modalPresentationStyle = .currentContext
            destinationVC.geoData = geoData
            present(destinationVC, animated: true, completion: nil)
        }
    }
}

