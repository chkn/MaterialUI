//
//  Elevation.swift
//  MaterialUI
//
//  Created by Alex Corrado on 10/12/19.
//  Copyright © 2019 Alex Corrado. All rights reserved.
//

import SwiftUI

// See MDCShadowMetrics in
//https://github.com/material-components/material-components-ios/blob/develop/components/ShadowLayer/src/MDCShadowLayer.m
public struct Elevation: ViewModifier {
    let kKeyShadowOpacity: Double = 0.26
    let kAmbientShadowOpacity: Double = 0.08

    let elevation: CGFloat

    var ambientShadowBlur: CGFloat {
        elevation <= 0 ? 0 : 0.889544 * elevation - 0.003701
    }

    var keyShadowBlur: CGFloat {
        elevation <= 0 ? 0 : 0.666920 * elevation - 0.001648
    }

    var keyShadowYOff: CGFloat {
        elevation <= 0 ? 0 : 1.23118 * elevation - 0.03933
    }

    public init(_ elevation: CGFloat)
    {
        self.elevation = elevation
    }

    public func body(content: Content) -> some View
    {
        content
            // top shadow
            .shadow(color: Color.primary.opacity(kAmbientShadowOpacity), radius: ambientShadowBlur, x: 0, y: 0)

            // key shadow
            .shadow(color: Color.primary.opacity(kKeyShadowOpacity), radius: keyShadowBlur, x: 0, y: keyShadowYOff)
    }
}

extension View {
    @inlinable public func elevation(_ elevation: CGFloat) -> some View
    {
        ModifiedContent(content: self, modifier: Elevation(elevation))
    }
}

#if DEBUG
struct Elevation_Previews: PreviewProvider {
    static var previews: some View {
        Color.red
            .frame(width: 30, height: 20)
            .modifier(Elevation(2))
    }
}
#endif
