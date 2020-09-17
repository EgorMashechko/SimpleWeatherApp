
import UIKit

class FinderCurrentTableViewCell: UITableViewCell {
    
//MARK: Properties
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    private var converter: MeasurementConverter?
    
//MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        converter = MeasurementConverter.shared
    }
    
//MARK: Methods
    func fillSelf(with geoData: GeoData?) {
        guard let cityName = geoData?.place?.city, let currentTemp = geoData?.weather?.current.temp else {
            cityLabel.text = ""
            tempLabel.text = ""
            return
        }
        cityLabel.text = cityName
        tempLabel.text = converter?.convertedTemperatureString(from: currentTemp)
    }
}
