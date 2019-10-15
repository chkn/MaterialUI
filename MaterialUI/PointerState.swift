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
}

struct PointerObserver: ViewModifier {
    @Binding var state: PointerState

    public init(updating: Binding<PointerState>)
    {
        self._state = updating
    }

    public func body(content: Content) -> some View
    {
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
                }
            }
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
