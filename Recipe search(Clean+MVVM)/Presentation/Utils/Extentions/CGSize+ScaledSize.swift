//
//  CGSize+ScaledSize.swift
//  Recipe search(Clean+MVVM)
//
//  Created by Sergey on 07.10.2021.
//

import Foundation
import UIKit

extension CGSize {
    var scaledSize: CGSize {
        .init(width: width * UIScreen.main.scale, height: height * UIScreen.main.scale)
    }
}
