
import Foundation
import CoreLocation

class WeatherAPIManager {
    
//MARK: Properties
    private let appId: String
    private let excludeWeatherTextApi: String
    private var languageApi: String {
        return String(Locale.current.languageCode?.prefix(2) ?? "en")
    }
    
//MARK: Initialization
    init() {
        appId = "1d2d01b68c141bb34fd1fd31f2d01196"
        excludeWeatherTextApi = "minutely"
    }
    
//MARK: Methods
    private func createApiWeatherIconString(withIconID iconID: String) -> String {
        let apiString = "https://openweathermap.org/img/wn/\(iconID)@2x.png"
        return apiString
    }
    
    private func createApiWeatherCallString(lat: Double, lon: Double) -> String {
        let apiString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=\(excludeWeatherTextApi)&lang=\(languageApi)&appid=\(appId)"
        return apiString
    }
    
    func callWeatherByLocation(_ location: CLLocation, completion: @escaping (WeatherData?) -> Void) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        let apiString = createApiWeatherCallString(lat: lat, lon: lon)
        
        if let apiUrl = URL(string: apiString) {
            let callDataTask = URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                /* handle response and errors */
                if let weatherData = data {
                    let decoder = JSONDecoder()
                    let weather = try? decoder.decode(WeatherData.self, from: weatherData)
                    completion(weather)
                }
            }
            callDataTask.resume()
        }
    }
    
    func callWeatherIcon(withID iconId: String, completion: @escaping (Data?) -> Void) {
        let apiString = createApiWeatherIconString(withIconID: iconId)
        if let apiUrl = URL(string: apiString) {
            let callDataTask = URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
                /* handle response and errors */
                DispatchQueue.main.async {
                    completion(data)
                }
            }
            callDataTask.resume()
        }
    }
    
}



