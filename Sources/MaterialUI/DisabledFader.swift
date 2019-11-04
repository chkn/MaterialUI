//
//  DisabledFader.swift
//  MaterialUI
//
//  Created by Alex Corrado on 11/3/19.
//  Copyright © 2019 Alex Corrado. All rights reserved.

import SwiftUI

struct DisabledFader: ViewModifier {
	@Environment(\.isEnabled) var isEnabled: Bool

	func body(content: Content) -> some View
	{
		content
			.compositingGroup()
			.opacity(isEnabled ? 1 : 0.5)
			.animation(nil)
	}
}
