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
	let kExpandRippleBeyondSurface: CGFloat = 10
	let kRippleStartingScale: CGFloat = 0.6
	let kRippleTouchDownDuration: Double = 0.2
	//let kRippleTouchUpDuration: Double = 0.15
	let kRippleFadeInOutDuration: Double = 0.075
	//let kRippleFadeOutDelay: CGFloat = 0.15

	let color: Color
	let cornerRadius: CGFloat

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
		case .down(let pt) where !rippleAppeared:
			return CGSize(width: pt.x - mX, height: pt.y - mY)
		default:
			return .zero
		}
	}

	func rippleShape(for size: CGSize) -> some View
	{
		let mX = size.width / 2
		let mY = size.height / 2
		let diameter = (hypot(mX, mY) + kExpandRippleBeyondSurface) * 2
		return Ellipse()
			.frame(width: diameter, height: diameter)
			.fixedSize()
			.offset(rippleOffset(mX, mY))
			.scaleEffect(rippleAppeared ? 1 : kRippleStartingScale)
			.animation(.easeInOut(duration: kRippleTouchDownDuration))
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
							.animation(.linear(duration: kRippleFadeInOutDuration))
					}
					// ripple
					if showRipple {
						RoundedRectangle(cornerRadius: cornerRadius)
							.fill(color.opacity(0.16))
							.animation(.linear(duration: kRippleFadeInOutDuration))
							.mask(GeometryReader { self.rippleShape(for: $0.size) })
							.onAppear { self.rippleAppeared = true }
							.onDisappear { self.rippleAppeared = false }
					}
				}
			)
			.modifier(PointerObserver(updating: $pointerState))
	}
}

public extension View {
	/// Causes a hover effect when the mouse is over the view and a ripple effect when the modified view is clicked/tapped
	func rippleEffect(_ color: Color, cornerRadius: CGFloat = 0) -> some View
	{
		ModifiedContent(content: self, modifier: Ripple(color: color, cornerRadius: cornerRadius))
	}
}
