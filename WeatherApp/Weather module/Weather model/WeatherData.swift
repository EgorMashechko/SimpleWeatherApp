
import Foundation

struct WeatherData: Codable {
    let timezoneOffset: Int
    let current: CurrentWeatherData
    let daily: [DailyWeatherData]
    let hourly: [HourlyWeatherData]
    
    enum CodingKeys: String, CodingKey {
        case timezoneOffset = "timezone_offset"
        case current
        case daily
        case hourly
    }
}

//MARK: Main weather data preferences
struct CurrentWeatherData: Codable {
    let dataTime: Int
//    let timezoneOffset: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Double
    let humidity: Double
    let visibility: Double
    let windSpeed: Double
    let windDeg: Double
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dataTime = "dt"
//        case timezoneOffset = "timezone_offset"
        case sunrise
        case sunset
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
    }
}

struct DailyWeatherData: Codable {
    let dataTime: Int
    let temp: DailyTemp
    let weather: [Weather]
    let precipitationsProb: Double
    
    enum CodingKeys: String, CodingKey {
        case dataTime = "dt"
        case temp
        case weather
        case precipitationsProb = "pop"
    }
}

//MARK: Common weather data preferences
struct HourlyWeatherData: Codable {
    let dataTime: Int
    let temp: Double
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dataTime = "dt"
        case temp
        case weather
    }
}

struct DailyTemp: Codable {
    let day: Double
    let night: Double
    let max: Double
    let min: Double
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

