//
//  Ripple.swift
//  MaterialUI
//
//  Created by Alex Corrado on 10/12/19.
//  Copyright © 2019 Alex Corrado. All rights reserved.
//

import SwiftUI

/// Causes a ripple effect when the modified view is clicked/tapped
public struct Ripple: ViewModifier {
    public func body(content: Content) -> some View
    {
        content.onTapGesture {
            
        }
    }
}

