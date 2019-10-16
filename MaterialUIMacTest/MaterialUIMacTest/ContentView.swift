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
    var body: some View {
        VStack(spacing: 10) {
            Button("Contained Button", action: { print("Contained") })
                .buttonStyle(ContainedButtonStyle())

            Button("Outlined Button", action: { print("Outlined") })
                .buttonStyle(OutlinedButtonStyle())

            Button("Text Button", action: { print("Text") })
                .buttonStyle(TextButtonStyle())
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
