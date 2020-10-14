
import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    
//MARK: Properties
    @IBOutlet weak var dailyCollectionView: UICollectionView!
    private let reusableCellID = "cellID"
    private var dailyWeatherData: [DailyWeatherData]?
    
//MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        
        dailyCollectionView.delegate = self
        dailyCollectionView.dataSource = self
        
        dailyCollectionView.register(UINib(nibName: "DailyCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reusableCellID)
    }
}

//MARK: UICollectionViewDelegate
extension DailyWeatherTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyWeatherData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellID, for: indexPath) as! DailyCollectionViewCell
        cell.fillSelf(with: dailyWeatherData?[indexPath.row])
        return cell
    }
}

//MARK: Fillable
extension DailyWeatherTableViewCell: Fillable {
    func fillSelf(with geoData: GeoData?) {
        dailyWeatherData = geoData?.weather?.daily
    }
}
