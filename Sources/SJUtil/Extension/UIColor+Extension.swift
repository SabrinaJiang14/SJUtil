//
//  File.swift
//  
//
//  Created by Eileen on 2021/6/15.
//

import Foundation
import GameKit

public extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    var random:UIColor {
        let shuffledDistribution = GKShuffledDistribution(lowestValue: 10, highestValue: 137)
        let num:CGFloat = CGFloat(Double(shuffledDistribution.nextInt()) / 255.0)
        let num2:CGFloat = CGFloat(Double(shuffledDistribution.nextInt()) / 255.0)
        let num3:CGFloat = CGFloat(Double(shuffledDistribution.nextInt()) / 255.0)
        
        let newColor = UIColor(red: num, green: num2, blue: num3, alpha: 1)
        return newColor
    }
    
    func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let rect = CGRect(origin: .zero, size: size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(self.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func colorWithHex(_ hex:String) -> UIColor {
        let hexint = Int(self.intFromHexString(hexStr: hex))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private func intFromHexString(hexStr: String) -> UInt64 {
        var hexInt: UInt64 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt64(&hexInt)
        return hexInt
    }
}
