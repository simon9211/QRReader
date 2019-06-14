//
//  QRTipsView.swift
//  
//
//  Created by xiwang wang on 2019/4/28.
//

import UIKit
import SnapKit

class QRTipsView: UIView {
    
    static let instance: QRTipsView = QRTipsView()
    
    private var tipIcon: UIImageView
    private var titleLabel: UILabel
    private var contentLabel: UILabel
    
    override init(frame: CGRect) {
        self.tipIcon = UIImageView()
        self.titleLabel = UILabel()
        self.contentLabel = UILabel()
        super.init(frame:CGRect(x: 0, y: 64, width: ScreenWidth, height: 64))
        self.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        addSubview(tipIcon)
        addSubview(titleLabel)
        addSubview(contentLabel)
        
        titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        
        tipIcon.image = UIImage(named: "tips")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(_ title: String, _ content: String, _ interval: TimeInterval = 2) {
        titleLabel.text = title
        contentLabel.text = content
        
        let window: UIWindow = UIApplication.shared.delegate!.window!!
        
        window.addSubview(self)
        
        UIView.animate(withDuration: 0.1) {
            self.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.dismiss()
        }
    }
    
    func dismiss() {
        removeFromSuperview()
        isHidden = true
    }
    
    override func updateConstraints() {
        
        tipIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(45)
            make.leading.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(tipIcon.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(25)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        get {
            return true
        }
    }
    
//    override class func requiresConstraintBasedLayout() -> Bool {
//        return true;
//    }
    
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
