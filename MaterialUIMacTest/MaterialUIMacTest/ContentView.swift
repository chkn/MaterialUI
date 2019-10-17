//
//  ContentView.swift
//  MaterialUIMacTest
//
//  Created by Alex Corrado on 10/14/19.
//  Copyright © 2019 Alex Corrado. All rights reserved.
//

import SwiftUI

import MaterialUI_Mac

struct ContentView: View {
    @State var disabled: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            Button("Contained Button", action: { print("Contained") })
                .buttonStyle(ContainedButtonStyle())
                .disabled(disabled)

            Button("Outlined Button", action: { print("Outlined") })
                .buttonStyle(OutlinedButtonStyle())
                .disabled(disabled)

            Button("Text Button", action: { print("Text") })
                .buttonStyle(TextButtonStyle())
                .disabled(disabled)

            Button("Enable/Disable", action: { self.disabled.toggle() })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 200, height: 200)
            .previewLayout(.fixed(width: 480, height: 300))
    }
}
