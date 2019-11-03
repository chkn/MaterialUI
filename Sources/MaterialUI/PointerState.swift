//
//  MouseState.swift
//  MaterialUI
//
//  Created by Alex Corrado on 10/14/19.
//  Copyright © 2019 Alex Corrado. All rights reserved.
//

import SwiftUI

/// The state of the mouse/finger with regard to a particular `View`
enum PointerState {

	/// The mouse is not over
	case none

	/// The mouse is over with no buttons pressed
	case hover

	/// The mouse/finger is pressed
	case down(at: CGPoint)

	/// Returns `true` if the mouse if hovering or if the mouse/finger is down
	public var isOver: Bool {
		switch self {
		case .none:
			return false
		default:
			return true
		}
	}
}

struct PointerObserver: ViewModifier {
	@Binding var state: PointerState
	let action: (() -> Void)?

	public init(updating: Binding<PointerState>, action: (() -> Void)? = nil)
	{
		self._state = updating
		self.action = action
	}

	public init(action: @escaping () -> Void)
	{
		self._state = BindingRefCell(initialValue: .none).binding
		self.action = action
	}

	public func body(content: Content) -> some View
	{
		#if HAVE_DRAG
			let gesture = DragGesture(minimumDistance: 0)
				.onChanged {
					// if self.state != .down
					if case .down(_) = self.state {} else {
						self.state = .down(at: $0.startLocation)
					}
				}
				.onEnded {_ in
					if case .down(_) = self.state {
						#if HAVE_HOVER
							self.state = .hover
						#else
							self.state = .none
						#endif
						if let fn = self.action {
							fn()
						}
					}
				}
		#else
			#error("Figure out how to get these events")
		#endif
		#if HAVE_HOVER
			return content
				.simultaneousGesture(gesture)
				.onHover { self.state = $0 ? .hover : .none }
		#else
			return content
				.simultaneousGesture(gesture)
		#endif
	}
}
