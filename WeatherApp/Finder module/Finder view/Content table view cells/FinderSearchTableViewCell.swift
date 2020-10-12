

import UIKit
import Firebase

//MARK: Delegate protocol
protocol FinderSearchCellDelegate: AnyObject {
    func searchCell (_ searchCell: FinderSearchTableViewCell, didLocationButtonTap sender: UIButton)
    func searchCell (_ searchCell: FinderSearchTableViewCell, didCityFindButtonTap sender: UIButton)
}

class FinderSearchTableViewCell: UITableViewCell {

//MARK: Properties
    @IBOutlet weak var locImageView: UIImageView!
    weak var delegate: FinderSearchCellDelegate?
    
//MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
   
//MARK: Methods
    @IBAction func onCityFindButton(_ sender: UIButton) {
        delegate?.searchCell(self, didCityFindButtonTap: sender)
    }
    
    @IBAction func onLocationButton(_ sender: UIButton) {
        delegate?.searchCell(self, didLocationButtonTap: sender)
    }
    
}

