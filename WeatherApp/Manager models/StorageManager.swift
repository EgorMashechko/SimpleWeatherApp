
import Foundation

class StorageManager {
    
//MARK: Properties
    private var fileManager = FileManager.default
    private var storagePathSuffix = "/Coordinates"
    private var storeDataPathSuffix = "/coordinate"
    private var storageURL: URL!
    var containsCoordinates: Bool {
        let storePath = storageURL.path + storagePathSuffix
        return fileManager.fileExists(atPath: storePath)
    }
    var storedCoordinates: Coordinates? {
        let storePath = storageURL.path + storagePathSuffix
        let decoder = JSONDecoder()
        guard let data = fileManager.contents(atPath: storePath) else {return nil}
        guard let coords = try? decoder.decode(Coordinates.self, from: data) else {return nil}
        return coords
    }
    
    static var shared = StorageManager()
    
//MARK: Initialization
    private init() {
        if let directory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            let storageDirectoryPath = directory.path + storagePathSuffix
            if fileManager.fileExists(atPath: storageDirectoryPath) == false {
                try? fileManager.createDirectory(atPath: storageDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }
            storageURL = URL(string: storageDirectoryPath)
        }
    }
    
//MARK: Methods
    func saveCoordinates(from geoData: GeoData?) {
        if let coordinates = geoData?.place?.coordinates {
            saveData(coordinates)
        }
    }
    
    private func saveData<T: Codable>(_ data: T) {
        let encoder = JSONEncoder()
        if let storeData = try? encoder.encode(data) {
            let storePath = storageURL.path + storagePathSuffix
            fileManager.createFile(atPath: storePath, contents: storeData, attributes: nil)
        }
    }
}
