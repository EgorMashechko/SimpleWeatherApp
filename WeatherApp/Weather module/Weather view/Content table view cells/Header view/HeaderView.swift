
import UIKit

//MARK: Delegate protocol
protocol HeaderViewDelegate: AnyObject {
    func headerView(_ view: HeaderView, didMenuButtonTap sender: UIButton)
}

class HeaderView: UIView {
    
//MARK: Properties
    @IBOutlet weak var imageView: UIImageView!
    weak var delegate: HeaderViewDelegate?
    
//MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

//MARK: Methods
    @IBAction func onMenuButton(_ sender: UIButton) {
        delegate?.headerView(self, didMenuButtonTap: sender)
    }
}
