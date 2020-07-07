//
//  Button.swift
//  MaterialUI
//
//  Created by Alex Corrado on 10/9/19.
//  Copyright © 2019 Alex Corrado. All rights reserved.
//

import SwiftUI

// Note that we wrap most stuff in a ViewModifier because @Environment doesn't work in (Primitive)ButtonStyle.

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

public struct ContainedButtonStyle: PrimitiveButtonStyle {
	private struct LabelModifier: ViewModifier {
		@Environment(\.isEnabled) var isEnabled: Bool
		@Environment(\.materialAccent) var accentColor: Color

		func body(content: Content) -> some View
		{
			content
				.modifier(MaterialButtonContent())
				.ripple(Color.white, cornerRadius: 4) // FIXME: should be foregroundColor
				.foregroundColor(Color.white) // FIXME: should be foregroundColor
				.background(isEnabled ? accentColor : Color.gray)
				.cornerRadius(4)
				.elevation(enabled: 2, hover: 4, mouseDown: 8)
		}
	}

	public init()
	{
	}

	public func makeBody(configuration: Self.Configuration) -> some View
	{
		configuration
			.label
			.modifier(LabelModifier())
			.modifier(PointerObserver(action: configuration.trigger))
	}
}

public struct OutlinedButtonStyle: PrimitiveButtonStyle {
	private struct LabelModifier: ViewModifier {
		@Environment(\.isEnabled) var isEnabled: Bool
        @Environment(\.materialAccent) var accentColor: Color

		func body(content: Content) -> some View
		{
			content
				.modifier(MaterialButtonContent())
				.ripple(accentColor, cornerRadius: 4)
				.foregroundColor(isEnabled ? accentColor : Color.gray)
				.overlay(
					RoundedRectangle(cornerRadius: 4)
						.stroke(isEnabled ? accentColor : Color.gray)
				)
		}
	}

	public init()
	{
	}

	public func makeBody(configuration: Self.Configuration) -> some View
	{
		configuration
			.label
			.modifier(LabelModifier())
			.modifier(PointerObserver(action: configuration.trigger))
	}
}

public struct TextButtonStyle: PrimitiveButtonStyle {
	private struct LabelModifier: ViewModifier {
		@Environment(\.isEnabled) var isEnabled: Bool
		@Environment(\.materialAccent) var accentColor: Color

		func body(content: Content) -> some View
		{
			content
				.modifier(MaterialButtonContent(xPadding: 8))
				.ripple(accentColor, cornerRadius: 4)
				.foregroundColor(isEnabled ? accentColor : Color.gray)
		}
	}

	public init()
	{
	}

	public func makeBody(configuration: Self.Configuration) -> some View
	{
		configuration
			.label
			.modifier(LabelModifier())
			.modifier(PointerObserver(action: configuration.trigger))
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
