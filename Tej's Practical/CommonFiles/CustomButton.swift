//
//  CustomButton.swift
//  Tej's Practical
//
//  Created by PCS29 on 11/04/21.
//

import Foundation
import UIKit

public class BottomButton : UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUI()
    }
    
    func setUI() {
        self.backgroundColor = UIColor.white
        self.setTitleColor(UIColor.blue, for: .normal)
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}

extension BottomButton {
    
    func setEnable() {
        self.backgroundColor = UIColor.blue
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        //self.isUserInteractionEnabled = true
    }
    
    func setDisable() {
        self.backgroundColor = UIColor.white
        self.setTitleColor(UIColor.blue, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        //self.isUserInteractionEnabled = false
    }
    
    func setBlueBorderGreen() {
        self.setBackgroundImage(nil, for: .normal)
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.black
//        self.backgroundColor = AppColor.ColorClear
//        self.setTitleColor(AppColor.ColorTeal, for: .normal)
//        self.titleLabel?.font = UIFont.Branding.Semibold(23)
    }
}
