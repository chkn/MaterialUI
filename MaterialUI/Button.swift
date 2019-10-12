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
    public func makeBody(configuration: Self.Configuration) -> some View
    {
        configuration.label
            .modifier(MaterialButtonContent())
            .foregroundColor(Color.white) // FIXME
            .background(Color.accentColor)
            .cornerRadius(4)
            .elevation(2)
    }
}

public struct OutlinedButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View
    {
        configuration.label
            .modifier(MaterialButtonContent())
            .foregroundColor(Color.accentColor)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.accentColor)
            )
    }
}

public struct TextButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View
    {
        configuration.label
            .modifier(MaterialButtonContent(xPadding: 8))
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
