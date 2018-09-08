//
//  Constants.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 26/04/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import Foundation
import UIKit

#if swift(>=4.2)
import UIKit.UIGeometry
extension UIEdgeInsets {
    public static let zero = UIEdgeInsets()
}
#endif

// Current Screeen sizes
let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let PlaceHolderColor = UIColor.white.withAlphaComponent(0.6)
