//
//  Extensions.swift
//  Todoey
//
//  Created by Cem Akkaya on 16/03/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import UIKit

// MARK: - UIColor Extension

extension UIColor {
    
    // 1. Random Color Creator
    
    static func randomFlat() -> UIColor {
        let red = CGFloat.random(in: 0.3 ... 0.9)
        let green = CGFloat.random(in: 0.3 ... 0.9)
        let blue = CGFloat.random(in: 0.3 ... 0.9)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    // 2. Converting Color to Hex Text (to save to Realm)
    
    func hexValue() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r*255) << 16 | (Int)(g*255) << 8 | (Int)(b*255) << 0
        
        return String(format: "#%06x", rgb).uppercased()
    }
    
    // 3. Converting Hex Text to Color (for reading in Realm)
    
    convenience init?(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    // 4. Finding the Contrasting Text Color (For Readability)
    func contrastingText() -> UIColor {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        // Luminance formula: Returns black text if the background is light, and white text if the background is dark.
        let luminance = 0.299 * r + 0.587 * g + 0.114 * b
        
        return luminance > 0.5 ? UIColor.black : UIColor.white
    }
}
