
import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
//MARK: Properties
    @IBOutlet weak var timeValueLabel: UILabel!
    @IBOutlet weak var temperatureValueLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    private var contentManager: WeatherAPIManager?
    private var converter: MeasurementConverter?
    
//MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentManager = WeatherAPIManager()
        converter = MeasurementConverter.shared
    }
    
//MARK: Methods
    func fillSelf(with hourlyWeatherData: HourlyWeatherData?, accordingTo zone: TimeZone?) {
        if let weatherData = hourlyWeatherData, let timezone = zone {
            setTimeValueWith(weatherData: weatherData, accordingTo: timezone)
            setTemperatureWith(weatherData: weatherData)
            setWeatherImageWith(weatherData: weatherData)
        }
    }
    
    private func setTimeValueWith(weatherData: HourlyWeatherData, accordingTo zone: TimeZone) {
        let weatherDate = Date(timeIntervalSince1970: TimeInterval(weatherData.dataTime))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = zone
        dateFormatter.timeStyle = .short
        let weatherTime = dateFormatter.string(from: weatherDate)
        
        timeValueLabel.text = weatherTime
    }
    
    private func setTemperatureWith(weatherData: HourlyWeatherData) {
        temperatureValueLabel.text = converter?.convertedTemperatureString(from: weatherData.temp)
    }
    
    private func setWeatherImageWith(weatherData: HourlyWeatherData) {
        if let iconID = weatherData.weather.first?.icon {
            contentManager?.callWeatherIcon(withID: iconID, completion: { (data) in
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.weatherImageView.image = image
                }
            })
        }
    }
}
