
import Foundation

class MeasurementConverter {
    
//MARK: Properties
    static var shared = MeasurementConverter()
    private var formatter: MeasurementFormatter
    
//MARK: Initialization
    private init() {
        formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.numberFormatter.roundingMode = .up
    }
    
//MARK: Methods
    func convertedTemperatureString(from temperature: Double) -> String {
        let measurement = Measurement(value: temperature, unit: UnitTemperature.kelvin)
        return formatter.string(from: measurement)
    }
    
    func convertedSpeedString(from speed: Double) -> String {
        let measurement = Measurement(value: speed, unit: UnitSpeed.metersPerSecond)
        return formatter.string(from: measurement)
    }
    
    func convertedDistanceString(from distance: Double) -> String {
        let measurement = Measurement(value: distance, unit: UnitLength.meters)
        return formatter.string(from: measurement)
    }
    
    func convertedPressureString(from pressure: Double) -> String {
        let measurement = Measurement(value: pressure, unit: UnitPressure.hectopascals)
        return formatter.string(from: measurement)
    }
}
