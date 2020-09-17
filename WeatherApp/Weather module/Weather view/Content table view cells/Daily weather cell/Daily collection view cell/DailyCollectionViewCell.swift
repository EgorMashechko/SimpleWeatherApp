
import UIKit

class DailyCollectionViewCell: UICollectionViewCell {
    
//MARK: Properties
    @IBOutlet weak var dayValueLabel: UILabel!
    @IBOutlet weak var temperatureDayValueLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureNightValueLabel: UILabel!
    private var contentManager: WeatherAPIManager?
    private var converter: MeasurementConverter?
    
//MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentManager = WeatherAPIManager()
        converter = MeasurementConverter.shared
    }
    
//MARK: Methods
    func fillSelf(with dailyWeatherData: DailyWeatherData?) {
        if let weatherData = dailyWeatherData {
            setDayValueWith(weatherData: weatherData)
            setTemperatureValuesWith(weatherData: weatherData)
            setWeatherIconWith(weatherData: weatherData)
        }
    }
    
    private func setDayValueWith(weatherData: DailyWeatherData) {
        let weatherDate = Date(timeIntervalSince1970: TimeInterval(weatherData.dataTime))
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("Md")
        dayValueLabel.text = dateFormatter.string(from: weatherDate)
    }
    
    private func setTemperatureValuesWith(weatherData: DailyWeatherData) {
        temperatureDayValueLabel.text = converter?.convertedTemperatureString(from: weatherData.temp.day)
        temperatureNightValueLabel.text = converter?.convertedTemperatureString(from: weatherData.temp.night)
    }
    
    private func setWeatherIconWith(weatherData: DailyWeatherData) {
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
