//
//  Fonts.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/30/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit

extension UIFont{
    
    enum ProximaNova: String{
        case black = "ProximaNova-Black"
        case bold = "ProximaNova-Bold"
        case extrabold = "ProximaNova-Extrabld"
        case light = "ProximaNova-Light"
        case regular = "ProximaNova-Regular"
        case semibold = "ProximaNova-Semibold"
        case thin = "name: ProximaNovaT-Thin"
    }
    
    private static let defaultSize: CGFloat = 14
    
    static func regular(_ size: CGFloat = defaultSize) -> UIFont{
        proximaNova(.regular, size: size)
    }
    
    static func light(_ size: CGFloat = defaultSize) -> UIFont{
        proximaNova(.light, size: size)
    }
    
    static func bold(_ size: CGFloat = defaultSize) -> UIFont{
        proximaNova(.bold, size: size)
    }
    
    static func black(_ size: CGFloat = defaultSize) -> UIFont{
        proximaNova(.black, size: size)
    }
    
    static func proximaNova(_ style: ProximaNova, size: CGFloat = defaultSize) -> UIFont{
        return UIFont(name: style.rawValue, size: size)!
    }
    
    static func printAllFonts(){
        for family in UIFont.familyNames {
          let sName: String = family as String
          print("family: \(sName)")

            for name in UIFont.fontNames(forFamilyName: sName) {
            print("name: \(name as String)")
          }
        }
    }
}
