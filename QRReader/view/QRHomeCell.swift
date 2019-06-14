//
//  QRHomeCell.swift
//  QRReader
//
//  Created by xiwang wang on 2019/3/21.
//  Copyright © 2019 com.simon. All rights reserved.
//

import UIKit

class QRHomeCell: UITableViewCell {

    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var tipsLabel: UILabel!
    @IBOutlet weak private var checkBoxBtn: UIButton!
    // 10 / 45
    @IBOutlet weak private var leadingOfIcon: NSLayoutConstraint!
    // 10 / -25
    @IBOutlet weak private var tailOfTitleLabel: NSLayoutConstraint!
    
    private var _isEdit: Bool = false
    private var _model: HomeItem = HomeItem()
    let format: DateFormatter = DateFormatter();
    var isEdit: Bool {
        set {
            _isEdit = newValue
            UIView.animate(withDuration: 0.25) {
                self.checkBoxBtn.isHidden = !self._isEdit
                self.leadingOfIcon.constant = self._isEdit ? 45 : 10
                self.tailOfTitleLabel.constant = self._isEdit ? -25 : 10
                self.timeLabel.isHidden = self._isEdit
            }
        }
        get{
            return _isEdit
        }
    }
    var model: HomeItem {
        set {
            _model = newValue
            titleLabel.text = _model.title
            tipsLabel.text = "\(_model.items) items";
            format.dateFormat = "yyyy/MM/dd"
            timeLabel.text = format.string(from: Date(timeIntervalSinceNow: TimeInterval(1000000 * (arc4random() % 10)  )))
            
            checkBoxBtn.isSelected = _model.isSelected
            switch model.fileType {
            case HomeFileType.none.rawValue:
                print("")
            case HomeFileType.code.rawValue:
                iconImageView.image = UIImage(named: "barcode")
            case HomeFileType.folder.rawValue:
                iconImageView.image = UIImage(named: "folder")
            case HomeFileType.web.rawValue:
                iconImageView.image = UIImage(named: "web")
            default:
                iconImageView.image = nil
            }
        }
        
        get{
            return _model
        }
    }
    
    // 选中事件传递
    var didSelectTap: ((_ selected: Bool) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func checkBoxSelect(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        didSelectTap!(sender.isSelected)
    }
    
    @IBAction func panCellAction(_ sender: UIButton, forEvent event: UIEvent) {
    }
    
}
