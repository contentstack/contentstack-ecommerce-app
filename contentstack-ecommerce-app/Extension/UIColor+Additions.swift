//
//  UIColor+Additions.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 19/09/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func hexStringToUIColor (hex: String) -> UIColor {
        let cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
        
        let scanner = Scanner(string: cString)
        if (cString.hasPrefix("#")) {
            scanner.scanLocation = 1
            if ((cString.count) != 7) {
                return UIColor.gray
            }
        }else if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        scanner.scanHexInt32(&rgbValue)
        
        return UIColor.RGBColor(r: CGFloat((rgbValue & 0xFF0000) >> 16), g: CGFloat((rgbValue & 0x00FF00) >> 8), b: CGFloat(rgbValue & 0x0000FF), alpha: CGFloat(1.0))
        
    }
    
    static func RGBColor(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
}
