//
//  MaterialColor.swift
//  MaterialUIMac
//
//  Created by Rob Jonson on 11/07/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

import SwiftUI


//introduce custom environment key to allow setting accent colour in MacOS
//https://medium.com/@SergDort/custom-environment-keys-in-swiftui-49f54a13d140
struct MaterialAccentColorKey: EnvironmentKey {
    static let defaultValue: Color = Color.accentColor
}

extension EnvironmentValues {
    
    /// Use to set accent colour in MacOS
    /// e.g.
    ///
    ///    Button("Outlined Button", action: {})
    ///    .buttonStyle(OutlinedButtonStyle())
    ///    .environment(\.materialAccent, Color.green)
    var materialAccent: Color {
        get {
            let color = self[MaterialAccentColorKey.self]
            return color
        }
        set {
            self[MaterialAccentColorKey.self] = newValue
        }
    }
}
