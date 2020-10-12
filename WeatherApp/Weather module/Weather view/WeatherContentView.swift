
import UIKit

//MARK: Delegate protocol
protocol WeatherContentViewDelegate: AnyObject {
    func weatherContentView(_ view: WeatherContentView, didMenuButtonTap sender: UIButton)
}

class WeatherContentView: UIView {

//MARK: Properties
    @IBOutlet weak var contentTableView: UITableView!
    private let currentGeneralCellID = "currentGeneral"
    private let currentExtendedCellID = "currentExtended"
    private let hourlyCellID = "hourly"
    private let dailyCellID = "daily"
    weak var delegate: WeatherContentViewDelegate?
    var geoData: GeoData?
    
//MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSelf()
    }
    
//MARK: Methods
    private func setupSelf() {
        if let contentView = Bundle.main.loadNibNamed("WeatherContentView", owner: self, options: nil)?.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            setupContentTableView()
        }
    }
    
    private func setupContentTableView() {
        contentTableView.backgroundColor = .clear
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        contentTableView.register(UINib(nibName: "CurrentGeneralWeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: currentGeneralCellID)
        contentTableView.register(UINib(nibName: "HourlyWeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: hourlyCellID)
        contentTableView.register(UINib(nibName: "DailyWeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: dailyCellID)
        contentTableView.register(UINib(nibName: "CurrentExtendedWeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: currentExtendedCellID)
    }
}

//MARK: UITableViewDelegate
extension WeatherContentView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: currentGeneralCellID, for: indexPath) as! CurrentGeneralWeatherTableViewCell
            cell.fillSelf(with: geoData)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: hourlyCellID, for: indexPath) as! HourlyWeatherTableViewCell
            cell.fillSelf(with: geoData)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: dailyCellID, for: indexPath) as! DailyWeatherTableViewCell
            cell.fillSelf(with: geoData)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: currentExtendedCellID, for: indexPath) as! CurrentExtendedWeatherTableViewCell
            cell.fillSelf(with: geoData)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return (tableView.frame.height - tableView.sectionHeaderHeight) * 0.75
        case 1, 2:
            return (tableView.frame.height - tableView.sectionHeaderHeight) / 4
        default:
            return (tableView.frame.height - tableView.sectionHeaderHeight) * 0.75
        }
    }
}

//MARK: HeaderViewDelegate
extension WeatherContentView: HeaderViewDelegate {
    func headerView(_ view: HeaderView, didMenuButtonTap sender: UIButton) {
        delegate?.weatherContentView(self, didMenuButtonTap: sender)
    }
}
