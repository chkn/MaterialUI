//
//  Ripple.swift
//  MaterialUI
//
//  Created by Alex Corrado on 10/12/19.
//  Copyright © 2019 Alex Corrado. All rights reserved.
//

import SwiftUI

fileprivate struct Ripple: ViewModifier {
	// https://github.com/material-components/material-components-ios/blob/develop/components/Ripple/src/private/MDCRippleLayer.m
	static let kExpandRippleBeyondSurface: CGFloat = 10
	static let kRippleStartingScale: CGFloat = 0.6
	static let kRippleTouchDownDuration: Double = 0.2
	//static let kRippleTouchUpDuration: Double = 0.15
	static let kRippleFadeInOutDuration: Double = 0.075
	//static let kRippleFadeOutDelay: CGFloat = 0.15

	// https://github.com/flutter/flutter/blob/62674cee3d61b170bfba227c503953adeec4bc0a/packages/flutter/lib/src/material/constants.dart#L37
	static let kRadialReactionDuration: Double = 0.15

	let color: Color
	let cornerRadius: CGFloat
	let offset: CGSize
	let isRadial: Bool

	var dimension: CGFloat? { isRadial ? cornerRadius * 2 : nil }

	@Environment(\.isEnabled) var isEnabled: Bool
	@State var pointerState: PointerState = .none
	@State var rippleAppeared: Bool = false

	var showRipple: Bool {
		switch pointerState {
		case .down(_) where isEnabled:
			return true
		default:
			return false
		}
	}

	func rippleOffset(_ mX: CGFloat, _ mY: CGFloat) -> CGSize
	{
		switch pointerState {
		case .down(let pt) where !isRadial && !rippleAppeared:
			return CGSize(width: pt.x - mX, height: pt.y - mY)
		default:
			return .zero
		}
	}

	func rippleShape(for size: CGSize) -> some View
	{
		let mX = size.width / 2
		let mY = size.height / 2
		let diameter = isRadial ? nil : (hypot(mX, mY) + Self.kExpandRippleBeyondSurface) * 2
		return Ellipse()
			.frame(width: diameter, height: diameter)
			.fixedSize(horizontal: !isRadial, vertical: !isRadial)
			.offset(rippleOffset(mX, mY))
			.scaleEffect(rippleAppeared ? 1 : Self.kRippleStartingScale)
			.animation(.easeInOut(duration: isRadial ? Self.kRadialReactionDuration : Self.kRippleTouchDownDuration))
	}

	public func body(content: Content) -> some View
	{
		content
			.overlay(
				ZStack {
					// hover
					if isEnabled {
						RoundedRectangle(cornerRadius: cornerRadius)
							.fill(color.opacity(pointerState.isOver ? 0.08 : 0))
							.frame(width: dimension, height: dimension)
							.animation(.linear(duration: Self.kRippleFadeInOutDuration))
					}
					// ripple
					if showRipple {
						RoundedRectangle(cornerRadius: cornerRadius)
							.fill(color.opacity(0.16))
							.frame(width: dimension, height: dimension)
							.animation(.linear(duration: Self.kRippleFadeInOutDuration))
							.mask(GeometryReader { self.rippleShape(for: $0.size) })
							.onAppear { self.rippleAppeared = true }
							.onDisappear { self.rippleAppeared = false }
					}
				}.offset(offset)
			)
			.modifier(PointerObserver(updating: $pointerState))
	}
}

public extension View {
	/// Causes a hover effect when the mouse is over the view and a ripple effect when the modified view is clicked/tapped
	func ripple(_ color: Color, cornerRadius: CGFloat = 0) -> some View
	{
		ModifiedContent(content: self, modifier: Ripple(color: color, cornerRadius: cornerRadius, offset: CGSize.zero, isRadial: false))
	}

	// Default radius is kRadialReactionRadius from: https://github.com/flutter/flutter/blob/62674cee3d61b170bfba227c503953adeec4bc0a/packages/flutter/lib/src/material/constants.dart#L34
	/// Causes a radial hover effect when the mouse is over the view and a ripple effect when the modified view is clicked/tapped
	func radialRipple(_ color: Color, radius: CGFloat = 20, offset: CGSize = CGSize.zero) -> some View
	{
		ModifiedContent(content: self, modifier: Ripple(color: color, cornerRadius: radius, offset: offset, isRadial: true))
	}
}
