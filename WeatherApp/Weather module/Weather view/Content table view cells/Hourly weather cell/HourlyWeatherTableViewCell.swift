
import UIKit

class HourlyWeatherTableViewCell: UITableViewCell {

//MARK: Properties
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    private let reusableCellID = "cellID"
    private let hoursPerDay = 24
    private var hourlyWeatherData: [HourlyWeatherData]?
    private var timezone: TimeZone?
    
//MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        
        hourlyCollectionView.delegate = self
        hourlyCollectionView.dataSource = self
        
        hourlyCollectionView.register(UINib(nibName: "HourlyCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reusableCellID)
    }
}

//MARK: UICollectionViewDelegate
extension HourlyWeatherTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hoursPerDay
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellID, for: indexPath) as! HourlyCollectionViewCell
        cell.fillSelf(with: hourlyWeatherData?[indexPath.row], accordingTo: timezone)
        return cell
    }
}

//MARK: Fillable
extension HourlyWeatherTableViewCell: Fillable {
    func fillSelf(with geoData: GeoData?) {
        if let geoData = geoData {
            hourlyWeatherData = geoData.weather?.hourly
            if let timezoneOffset = geoData.weather?.timezoneOffset {
                timezone = TimeZone(secondsFromGMT: timezoneOffset)
            }
        }
    }
}
