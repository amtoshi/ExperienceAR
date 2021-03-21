//
//  Utility.swift
//  Experience
//
//  Created by Ashutosh Mane on 20.03.2021.
//  Copyright © 2021 Ashutosh Mane. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
}
