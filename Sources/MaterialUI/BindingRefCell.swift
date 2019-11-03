//
//  BindingRefCell.swift
//  MaterialUI
//
//  Created by Alex Corrado on 10/15/19.
//  Copyright © 2019 Alex Corrado. All rights reserved.
//

import SwiftUI

class BindingRefCell<T> {
	public var value: T

	public var binding: Binding<T> {
		Binding<T>(get: { self.value }, set: { self.value = $0 })
	}

	public init(initialValue: T)
	{
		self.value = initialValue
	}
}
