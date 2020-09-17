
import UIKit

class FinderViewController: UIViewController {

//MARK: Properties
    @IBOutlet weak var finderTableView: UITableView!
    var geoData: GeoData?
    private lazy var finder: GeoDataFinder = {
        let finder = GeoDataFinder(target: self)
        finder.delegate = self
        return finder
    }()
    
//MARK: Controller lifecycle methods
    override func loadView() {
        let contentView = FinderContentView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contentView = self.view as? FinderContentView {
            contentView.geoData = geoData
            contentView.delegate = self
        }
    }
    
//MARK: Methods
    private func presentWeather(with geoData: GeoData?) {
        let storyboard = UIStoryboard(name: "Weather", bundle: Bundle.main)
        if let destinationVC = storyboard.instantiateInitialViewController() as? WeatherViewController {
            destinationVC.geoData = geoData
            destinationVC.modalPresentationStyle = .currentContext
            self.present(destinationVC, animated: true, completion: nil)
        }
    }
}

//MARK: Delegate methods
extension FinderViewController: FinderContentViewDelegate {
    func didSelectPresentCurrentWeather() {
        if let _geoData = geoData {
            presentWeather(with: _geoData)
        }
    }
    
    func didLocationButtonTap() {
        finder.findByCurrentLocation()
    }
    
    func didFindCityButtonTap() {
        finder.findByCity()
    }
}

extension FinderViewController: GeoDataFinderDelegate {
    func didGeoDataFinded(with geoData: GeoData?) {
        DispatchQueue.main.async {
            self.presentWeather(with: geoData)
        }
    }
}
