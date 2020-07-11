//
//  Toggle.swift
//  MaterialUI
//
//  Created by Alex Corrado on 11/3/19.
//  Copyright © 2019 Alex Corrado. All rights reserved.
//

import SwiftUI

public struct MaterialSwitchToggleStyle: ToggleStyle {
	@Environment(\.materialAccent) var accentColor: Color
    
    // https://github.com/flutter/flutter/blob/ee032f67c734e607d8ea5c870ba744daf4bf56e7/packages/flutter/lib/src/material/switch.dart#L19
	// FIXME: https://material.io/components/selection-controls/#specs says it should be 20 x 36 .. what gives?
	static let _kTrackHeight: CGFloat = 14.0;
	static let _kTrackWidth: CGFloat = 33.0;
	static let _kTrackRadius: CGFloat = _kTrackHeight / 2.0;
	static let _kThumbRadius: CGFloat = 10.0;

	// https://github.com/flutter/flutter/blob/a1c5e3354be7e0c391447d958bc546629bbe148a/packages/flutter/lib/src/material/toggleable.dart#L14
	// FIXME: ^^ above says 0.2 but material.io is much faster
	static let _kToggleDuration: Double = 0.1

	static let thumbDiameter = _kThumbRadius * 2

	public init()
	{
	}

	func makeSwitch(_ configuration: Self.Configuration) -> some View
	{
		let anim = Animation.linear(duration: Self._kToggleDuration)
		let offset = CGSize(width: configuration.isOn ? Self._kThumbRadius : -Self._kThumbRadius, height: 0)
		return ZStack {
			// track
			RoundedRectangle(cornerRadius: Self._kTrackRadius)
				.fill((configuration.isOn ? accentColor : Color.gray).opacity(0.54))
				.frame(width: Self._kTrackWidth, height: Self._kTrackHeight)

			// thumb
			Circle()
				.fill(configuration.isOn ? accentColor : Color.white)
				.frame(width: Self.thumbDiameter, height: Self.thumbDiameter)
				.offset(offset)
				.animation(anim)
				.elevation(2)
			}
			.modifier(DisabledFader())
			.radialRipple(configuration.isOn ? accentColor : Color.primary, offset: offset)
			.animation(anim)
			.modifier(PointerObserver(action: { configuration.isOn.toggle() }))
	}

	public func makeBody(configuration: Self.Configuration) -> some View
	{
		HStack {
			configuration.label
			Spacer()
			makeSwitch(configuration)
		}
	}
}


#if DEBUG
struct Toggle_Previews: PreviewProvider {
	static var toggles: some View {
		VStack {
			Toggle("Toggle On", isOn: Binding.constant(true))
			Toggle("Toggle Off", isOn: Binding.constant(false))
		}.padding(10)
	}

	static var previews: some View {
		Group {
			toggles
				.toggleStyle(DefaultToggleStyle())
				.previewDisplayName("DefaultToggleStyle")
				.previewLayout(.fixed(width: 200, height: 150))

			toggles
				.toggleStyle(SwitchToggleStyle())
				.previewDisplayName("SwitchToggleStyle")
				.previewLayout(.fixed(width: 200, height: 150))

			toggles
				.toggleStyle(MaterialSwitchToggleStyle())
				.previewDisplayName("MaterialSwitchToggleStyle")
				.previewLayout(.fixed(width: 200, height: 150))

			List(["Foo", "Bar", "Baz"], id: \.self) { label in
				Toggle(label, isOn: Binding.constant(true))
			}
			.previewLayout(.fixed(width: 200, height: 150))

			List(["Foo", "Bar", "Baz"], id: \.self) { label in
				Toggle(label, isOn: Binding.constant(true))
			}
			.toggleStyle(MaterialSwitchToggleStyle())
			.previewLayout(.fixed(width: 200, height: 150))
		}
	}
}
#endif
