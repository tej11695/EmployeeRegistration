//
//  CardView.swift
//  Tej's Practical
//
//  Created by PCS29 on 11/04/21.
//

import Foundation
import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerradius: CGFloat = 5
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 0
    @IBInspectable var shadowcolor: UIColor? = UIColor.black
    @IBInspectable var bordercolor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0
    @IBInspectable var borderwidth: CGFloat = 2.0


    override func layoutSubviews() {
        layer.cornerRadius = cornerradius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
    
        layer.masksToBounds = false
        layer.shadowColor = shadowcolor?.cgColor
        layer.borderColor = bordercolor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.borderWidth = borderwidth
    }
}
