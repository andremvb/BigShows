//
//  PreviewDevice.swift
//  GOX
//
//  Created by Andre Valdivia on 5/22/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import SwiftUI

#if DEBUG
@available(iOS 13.0, *)
extension PreviewDevice{
    
    static var iphoneSE = PreviewDevice(rawValue: "iPhone SE")
    static var iphoneXSMax = PreviewDevice(rawValue: "iPhone XS Max")
    
}
#endif
