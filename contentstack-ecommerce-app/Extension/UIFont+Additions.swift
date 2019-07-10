//
//  UIFont+Additions.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 19/09/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import Foundation
import UIKit

enum FontSFProDisplay: String {
    case ThinItalic = "SFProDisplay-ThinItalic"
    case Ultralight = "SFProDisplay-Ultralight"
    case BoldItalic = "SFProDisplay-BoldItalic"
    case Regular = "SFProDisplay-Regular"
    case Bold = "SFProDisplay-Bold"
    case MediumItalic = "SFProDisplay-MediumItalic"
    case Thin = "SFProDisplay-Thin"
    case Light = "SFProDisplay-Light"
    case UltralightItalic = "SFProDisplay-UltralightItalic"
    case Italic = "SFProDisplay-Italic"
    case LightItalic = "SFProDisplay-LightItalic"
    case Medium = "SFProDisplay-Medium"
}

extension UIFont {
    
    static func applicationFontSFProDisplayThinItalic(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.ThinItalic.rawValue, size: fontSize)!
    }
    
    static func applicationFontSFProDisplayUltralight(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.Ultralight.rawValue, size: fontSize)!
    }
    
    static func applicationFontSFProDisplayBoldItalic(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.BoldItalic.rawValue, size: fontSize)!
    }
    
    static func applicationFontSFProDisplayRegular(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.Regular.rawValue, size: fontSize)!
    }
    
    static func applicationFontSFProDisplayBold(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.Bold.rawValue, size: fontSize)!
    }
    
    static func applicationFontSFProDisplayMediumItalic(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.MediumItalic.rawValue, size: fontSize)!
    }
    
    static func applicationFontSFProDisplayThin(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.Thin.rawValue, size: fontSize)!
    }
    
    static func applicationFontSFProDisplayLight(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.Light.rawValue, size: fontSize)!
    }
    
    static func applicationFontSFProDisplayUltralightItalic(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.UltralightItalic.rawValue, size: fontSize)!
    }
    
    static func applicationFontSFProDisplayItalic(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.Italic.rawValue, size: fontSize)!
    }
    
    static func applicationFontSFProDisplayLightItalic(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.LightItalic.rawValue, size: fontSize)!
    }
    
    static func applicationFontSFProDisplayMedium(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FontSFProDisplay.Medium.rawValue, size: fontSize)!
    }
    
}
