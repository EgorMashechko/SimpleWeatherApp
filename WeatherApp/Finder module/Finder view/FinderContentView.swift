
import UIKit

//MARK: Delegate protocol
protocol FinderContentViewDelegate: AnyObject {
    func didSelectPresentCurrentWeather()
    func didLocationButtonTap()
    func didFindCityButtonTap()
}

class FinderContentView: UIView {

//MARK: Properties
    @IBOutlet weak var contentTableView: UITableView!
    var geoData: GeoData?
    weak var delegate: FinderContentViewDelegate?
    private let currentdID = "currentCell"
    private let searchCellID = "searchCell"
    
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
        if let contentView = Bundle.main.loadNibNamed("FinderContentView", owner: self, options: nil)?.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            setupContentTableView()
        }
    }
    
    private func setupContentTableView() {
        contentTableView.backgroundColor = .clear
        contentTableView.tableFooterView = UIView()
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        contentTableView.register(UINib(nibName: "FinderCurrentTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: currentdID)
        contentTableView.register(UINib(nibName: "FinderSearchTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: searchCellID)
    }
    
}

//MARK: Delegate methods
extension FinderContentView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: currentdID, for: indexPath) as! FinderCurrentTableViewCell
            cell.fillSelf(with: geoData)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: searchCellID, for: indexPath) as! FinderSearchTableViewCell
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return tableView.bounds.height / 8
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if geoData != nil {
                delegate?.didSelectPresentCurrentWeather()
            }
        default:
            return
        }
    }
}

extension FinderContentView: FinderSearchCellDelegate {
    func searchCell(_ searchCell: FinderSearchTableViewCell, didLocationButtonTap sender: UIButton) {
        delegate?.didLocationButtonTap()
    }
    
    func searchCell(_ searchCell: FinderSearchTableViewCell, didCityFindButtonTap sender: UIButton) {
        delegate?.didFindCityButtonTap()
    }
}
