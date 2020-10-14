
import UIKit


class CurrentGeneralWeatherTableViewCell: UITableViewCell {
    
//MARK: Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureFeelsLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    private var manager: WeatherAPIManager?
    private var converter: MeasurementConverter?

//MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        manager = WeatherAPIManager()
        converter = MeasurementConverter.shared
    }
    
//MARK: Methods
    private func setCityDescription(with place: PlaceData) {
        cityLabel.text = place.city ?? ""
        let descriptionText = (place.region ?? "") + " " + (place.country ?? "")
        cityDescriptionLabel.text = descriptionText
    }
    
    private func setWeatherDate(with currentWeather: CurrentWeatherData) {
        let dateFormatter = DateFormatter()
        let currentDate = Date(timeIntervalSince1970: TimeInterval(currentWeather.dataTime))
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        dateLabel.text = dateFormatter.string(from: currentDate)
    }
    
    private func setTemperatureValues(with currentWeather: CurrentWeatherData) {
        temperatureLabel.text = converter?.convertedTemperatureString(from: currentWeather.temp)
        let tempString = converter?.convertedTemperatureString(from: currentWeather.feelsLike)
        let prefixString = NSLocalizedString("feels_like", comment: "")
        let feelsTempString = prefixString + " " + (tempString ?? "")
        temperatureFeelsLabel.text = feelsTempString
    }
    
    private func setWeatherDescription(with currentWeather: CurrentWeatherData) {
        weatherDescriptionLabel.text = currentWeather.weather.first?.description.capitalized ?? ""
    }
    
    private func setWeatherImage(with currentWeather: CurrentWeatherData) {
        if let iconID = currentWeather.weather.first?.icon {
            manager?.callWeatherIcon(withID: iconID, completion: { (data) in
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.weatherImageView.image = image
                }
            })
        }
    }
}

//MARK: Fillable
extension CurrentGeneralWeatherTableViewCell: Fillable {
    func fillSelf(with geoData: GeoData?) {
        if let currentWeather = geoData?.weather?.current, let place = geoData?.place {
            
            setCityDescription(with: place)
            setWeatherDate(with: currentWeather)
            setTemperatureValues(with: currentWeather)
            setWeatherImage(with: currentWeather)
            setWeatherDescription(with: currentWeather)
        }
    }
}
