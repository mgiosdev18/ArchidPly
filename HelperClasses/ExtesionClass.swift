//
//  ExtesionClass.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 26/04/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Bundle
extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
//MARK: - UIColor
extension UIColor {
    
    /// Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it.
    ///
    /// - Returns: `self` as a 1x1 `UIImage`.
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func getCustomOrangeColor() -> UIColor{
        return UIColor(red: 240/255.0, green: 131/255.0, blue: 48/255.0, alpha:1)
    }
    class func getCustomGreyColor() -> UIColor{
        return UIColor(red:149/255, green:152/255 ,blue:154/255 , alpha:1.0)
    }
 
}
//MARK: - UIImageView
extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
//MARK: - UITextField
extension UITextField {
    func setBottomBorder(withColor:UIColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = withColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 0.0
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}
//MARK: - UITextView
extension UITextView{
    func setBottomBorder(withColor:UIColor) {
        self.layer.backgroundColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = withColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 0.0
    }
    
}













