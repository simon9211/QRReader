//
//  QRHomeCell.swift
//  QRReader
//
//  Created by xiwang wang on 2019/3/21.
//  Copyright © 2019 com.simon. All rights reserved.
//

import UIKit

class QRHomeCell: UITableViewCell {

    var _isEdit: Bool = false
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
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    // 10 / 45
    @IBOutlet weak var leadingOfIcon: NSLayoutConstraint!
    // 10 / -25
    @IBOutlet weak var tailOfTitleLabel: NSLayoutConstraint!
    
    // 选中事件传递
    var didSelectTap: ((_ selected: Bool) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkBoxSelect(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        didSelectTap!(sender.isSelected)
    }
    
    @IBAction func panCellAction(_ sender: UIButton, forEvent event: UIEvent) {
    }
    
}
