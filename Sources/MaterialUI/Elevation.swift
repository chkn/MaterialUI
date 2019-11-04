//
//  Elevation.swift
//  MaterialUI
//
//  Created by Alex Corrado on 10/12/19.
//  Copyright © 2019 Alex Corrado. All rights reserved.
//

import SwiftUI

fileprivate struct Elevation: ViewModifier {
	//https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/constants.dart#L31
	static let kThemeChangeDuration: Double = 0.2

	// See MDCShadowMetrics in
	//https://github.com/material-components/material-components-ios/blob/develop/components/ShadowLayer/src/MDCShadowLayer.m
	static let kKeyShadowOpacity: Double = 0.26
	static let kAmbientShadowOpacity: Double = 0.08

	let enabled: CGFloat
	let disabled: CGFloat

	// The following only apply when enabled:
	let hover: CGFloat
	let mouseDown: CGFloat

	@Environment(\.isEnabled) var isEnabled: Bool
	@State var pointerState: PointerState = .none

	var elevation: CGFloat {
		if !isEnabled {
			return disabled
		}
		switch pointerState {
		case .none: return enabled
		case .hover: return hover
		case .down(_): return mouseDown
		}
	}

	var ambientShadowBlur: CGFloat {
		elevation <= 0 ? 0 : 0.889544 * elevation - 0.003701
	}

	var keyShadowBlur: CGFloat {
		elevation <= 0 ? 0 : 0.666920 * elevation - 0.001648
	}

	var keyShadowYOff: CGFloat {
		elevation <= 0 ? 0 : 1.23118 * elevation - 0.03933
	}

	public func body(content: Content) -> some View
	{
		content
			.animation(nil)
			// top shadow
			.shadow(color: Color.black.opacity(Self.kAmbientShadowOpacity), radius: ambientShadowBlur, x: 0, y: 0)

			// key shadow
			.shadow(color: Color.black.opacity(Self.kKeyShadowOpacity), radius: keyShadowBlur, x: 0, y: keyShadowYOff)

			// FIXME: Is this the correct curve?
			.animation(isEnabled ? Animation.easeInOut(duration: Self.kThemeChangeDuration) : nil)
			.modifier(PointerObserver(updating: $pointerState))
	}
}

public extension View {
	/// Sets the view's elevation.
	func elevation(_ elevation: CGFloat) -> some View
	{
		ModifiedContent(content: self, modifier: Elevation(enabled: elevation, disabled: elevation, hover: elevation, mouseDown: elevation))
	}

	/// Sets the view's elevation in different states.
	func elevation(enabled: CGFloat, hover: CGFloat, mouseDown: CGFloat, disabled: CGFloat = 0) -> some View
	{
		ModifiedContent(content: self, modifier: Elevation(enabled: enabled, disabled: disabled, hover: hover, mouseDown: mouseDown))
	}
}

#if DEBUG
struct Elevation_Previews: PreviewProvider {
	static var previews: some View {
		Color.red
			.frame(width: 30, height: 20)
			.elevation(2)
	}
}
#endif
