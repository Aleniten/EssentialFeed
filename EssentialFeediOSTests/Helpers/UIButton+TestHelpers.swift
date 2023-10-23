//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Jose Herrero on 2023-10-23.
//

import UIKit

extension UIButton {
    func simulateTap() {
        allTargets.forEach { target in
            simulate(event: .touchUpInside)
        }
    }
}
