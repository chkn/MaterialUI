# MaterialUI

[Material design](https://material.io) components for SwiftUI. 

## Work in Progress

This project is in the very early stages, and some stuff will probably change. For instance, we ultimately intend to build and ship via the Swift Package Manager, but for now, we are building Xcode framework targets to facilitate development with SwiftUI previews.

Help is always welcome!

## Components

- [Buttons](#buttons)
- [Modifiers](#modifiers)

### Buttons

There are 3 styles of [material buttons](https://material.io/components/buttons):

- [Contained](#contained)
- [Outlined](#outlined)
- [Text](#text)

The button style is selected with the `buttonStyle` modifier, which may be used on any view to specify the style used for all buttons in that subview hierarchy.

#### Contained

```swift
Button("Contained Button", action: {})
	.buttonStyle(ContainedButtonStyle())
```

![Contained Button](docs/img/ContainedButton.gif)

#### Outlined

```swift
Button("Outlined Button", action: {})
	.buttonStyle(OutlinedButtonStyle())
```

![Outlined Button](docs/img/OutlinedButton.gif)

#### Text

```swift
Button("Text Button", action: {})
	.buttonStyle(TextButtonStyle())
```

![Text Button](docs/img/TextButton.gif)

### Modifiers

MaterialUI also supplies some modifiers you can apply to any SwiftUI View:

- elevation
- rippleEffect

TODO: Document these.
