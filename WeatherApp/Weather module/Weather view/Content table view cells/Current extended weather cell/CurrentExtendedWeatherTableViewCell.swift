
import UIKit

class CurrentExtendedWeatherTableViewCell: UITableViewCell {
    
//MARK: Properties
    @IBOutlet weak var mainWeatherLabel: UILabel!
    @IBOutlet weak var dailyMinTemp: UILabel!
    @IBOutlet weak var dailyMaxTemp: UILabel!
    @IBOutlet weak var precipitations: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var pressureValueLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var visibilityValueLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windSpeedValueLabel: UILabel!
    private var converter: MeasurementConverter?
    
//MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        converter = MeasurementConverter.shared
        
        sunriseLabel.text = NSLocalizedString("sunrise", comment: "")
        sunsetLabel.text = NSLocalizedString("sunset", comment: "")
        pressureLabel.text = NSLocalizedString("pressure", comment: "")
        humidityLabel.text = NSLocalizedString("humidity", comment: "")
        visibilityLabel.text = NSLocalizedString("visibility", comment: "")
        windSpeedLabel.text = NSLocalizedString("wind_speed", comment: "")
    }
    
//MARK: Methods
    private func setDescription(with weatherData: WeatherData){
        if let currentDayWeather = weatherData.daily.first {
            if let description = currentDayWeather.weather.first?.description {
                mainWeatherLabel.text = NSLocalizedString("today", comment: "") + ": " + description + ","
            }
            if let maxTemp = converter?.convertedTemperatureString(from: currentDayWeather.temp.max) {
                dailyMaxTemp.text = NSLocalizedString("max_temp", comment: "") + " " + maxTemp + ","
            }
            if let minTemp = converter?.convertedTemperatureString(from: currentDayWeather.temp.min) {
                dailyMinTemp.text = NSLocalizedString("min_temp", comment: "") + " " + minTemp + ","
            }
            precipitations.text = NSLocalizedString("precipitation_prob", comment: "") + " " + String(Int(currentDayWeather.precipitationsProb)).percentaged
        }
    }
    
    private func setSunCycleTime(with currentWeather: CurrentWeatherData, accordingTo zone: TimeZone) {
        let sunriseValue = Date(timeIntervalSince1970: TimeInterval(currentWeather.sunrise))
        let sunsetValue = Date(timeIntervalSince1970: TimeInterval(currentWeather.sunset))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = zone
        dateFormatter.timeStyle = .short
        let sunsetTime = dateFormatter.string(from: sunsetValue)
        let sunriseTime = dateFormatter.string(from: sunriseValue)
        
        sunriseTimeLabel.text = sunriseTime
        sunsetTimeLabel.text = sunsetTime
    }
    
    private func setWeatherValues(with currentWeather: CurrentWeatherData) {
        let humidity = Int(currentWeather.humidity.rounded())
        humidityValueLabel.text = String(humidity).percentaged
        let pressure = currentWeather.pressure
        pressureValueLabel.text = converter?.convertedPressureString(from: pressure)
        let visibility = currentWeather.visibility
        visibilityValueLabel.text = converter?.convertedDistanceString(from: visibility)
        let windSpeed = currentWeather.windSpeed
        windSpeedValueLabel.text = converter?.convertedSpeedString(from: windSpeed)
    }
}

//MARK: Fillable
extension CurrentExtendedWeatherTableViewCell: Fillable {
    func fillSelf(with geoData: GeoData?) {
        if let weather = geoData?.weather {
            setWeatherValues(with: weather.current)
            setDescription(with: weather)
            if let timezone = TimeZone(secondsFromGMT: weather.timezoneOffset) {
                setSunCycleTime(with: weather.current, accordingTo: timezone)
            }
        }
    }
}
