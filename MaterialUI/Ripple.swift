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
    // https://github.com/material-components/material-components-ios/blob/develop/components/Ripple/src/private/MDCRippleLayer.m
    //let kExpandRippleBeyondSurface: CGFloat = 10
    let kRippleStartingScale: CGFloat = 0.6
    let kRippleTouchDownDuration: CGFloat = 0.225
    //let kRippleTouchUpDuration: CGFloat = 0.15
    let kRippleFadeInOutDuration: Double = 0.075
    let kRippleFadeOutDelay: CGFloat = 0.15

    let color: Color
    let cornerRadius: CGFloat

    @State var pointerState: PointerState = .none

    var opacity: Double {
        switch pointerState {
        case .none:
            return 0
        case .hover:
            return 0.08
        case .down(_):
            return 0.16
        }
    }

    public func body(content: Content) -> some View
    {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color.opacity(opacity))
            )
            .animation(.linear(duration: kRippleFadeInOutDuration))
            .modifier(PointerObserver(updating: $pointerState))
    }
}

