// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "MaterialUI",
	platforms: [
		.macOS(.v10_15),
		.iOS(.v13),
		.tvOS(.v13),
		.watchOS(.v6),
	],
	products: [
		// Main library
		.library(name: "MaterialUI", targets: ["MaterialUI"]),
	],
	dependencies: [],
	targets: [
		.target(name: "MaterialUI")
	]
)
