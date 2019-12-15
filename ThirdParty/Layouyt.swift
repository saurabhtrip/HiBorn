//
//  LayoutController.swift
//  TaxSeries
//
//  Created by localadmin on 11/23/18.
//  Copyright © 2018 subtlelalbs. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class DesignableView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var rotation: Int {
        get {
            return 0
        } set {
            let radians = CGFloat(CGFloat(Double.pi) * CGFloat(newValue) / CGFloat(180.0))
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
    
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
        
        
        
    }
    
}
//@IBDesignable extension UIView {
//    @IBInspectable var shadowColor: UIColor?{
//        set {
//            guard let uiColor = newValue else { return }
//            layer.shadowColor = uiColor.cgColor
//        }
//        get{
//            guard let color = layer.shadowColor else { return nil }
//            return UIColor(cgColor: color)
//        }
//    }
//
//    @IBInspectable var shadowOpacity: Float{
//        set {
//            layer.shadowOpacity = newValue
//        }
//        get{
//            return layer.shadowOpacity
//        }
//    }
//
//    @IBInspectable var shadowOffset: CGSize{
//        set {
//            layer.shadowOffset = newValue
//        }
//        get{
//            return layer.shadowOffset
//        }
//    }
//
//    @IBInspectable var shadowRadius: CGFloat{
//        set {
//            layer.shadowRadius = newValue
//        }
//        get{
//            return layer.shadowRadius
//        }
//    }
//}
