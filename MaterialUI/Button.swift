//
//  Button.swift
//  MaterialUI
//
//  Created by Alex Corrado on 10/9/19.
//  Copyright © 2019 Alex Corrado. All rights reserved.
//

import SwiftUI

/// A `ViewModifier` that applies to all Material buttons.
struct MaterialButtonContent: ViewModifier {
    var xPadding: CGFloat = 16
    @Environment(\.font) private var font

    func body(content: Content) -> some View
    {
        content
            .font((font ?? Font.body).smallCaps())
            .padding(.leading, xPadding)
            .padding(.trailing, xPadding)
            .padding(.top, 8)
            .padding(.bottom, 8)
    }
}

public struct ContainedButtonStyle: ButtonStyle {
    public init()
    {
    }

    public func makeBody(configuration: Self.Configuration) -> some View
    {
        configuration.label
            .modifier(MaterialButtonContent())
            .modifier(Ripple(color: Color.white, cornerRadius: 4)) // FIXME: should be foregroundColor
            .foregroundColor(Color.white) // FIXME: should be foregroundColor
            .background(Color.accentColor)
            .cornerRadius(4)
            .elevation(enabled: 2, hover: 4, mouseDown: 8)
    }
}

public struct OutlinedButtonStyle: ButtonStyle {
    public init()
    {
    }

    public func makeBody(configuration: Self.Configuration) -> some View
    {
        configuration.label
            .modifier(MaterialButtonContent())
            .modifier(Ripple(color: Color.accentColor, cornerRadius: 4))
            .foregroundColor(Color.accentColor)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.accentColor)
            )
    }
}

public struct TextButtonStyle: ButtonStyle {
    public init()
    {
    }

    public func makeBody(configuration: Self.Configuration) -> some View
    {
        configuration.label
            .modifier(MaterialButtonContent(xPadding: 8))
            .modifier(Ripple(color: Color.accentColor, cornerRadius: 4))
            .foregroundColor(Color.accentColor)
    }
}

#if DEBUG
struct Button_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button("Button", action: {})
                .buttonStyle(ContainedButtonStyle())
                .previewDisplayName("ContainedButtonStyle")

            Button("Button", action: {})
                .buttonStyle(OutlinedButtonStyle())
                .previewDisplayName("OutlinedButtonStyle")

            Button("Button", action: {})
                .buttonStyle(TextButtonStyle())
                .previewDisplayName("TextButtonStyle")

        }.previewLayout(PreviewLayout.fixed(width: 150, height: 100))
    }
}
#endif
