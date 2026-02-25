//
//  UniversalSafeAreaBar.swift
//  dogubako
//
//  Created by Johannes Jakob on 25/02/2026
//

import SwiftUI

private struct UniversalSafeAreaBar<Bar: View>: ViewModifier {
	// MARK: Properties

	let edge: VerticalEdge
	let alignment: HorizontalAlignment
	let spacing: CGFloat?
	let toolbarBackgroundHidden: Bool
	let bar: Bar

	// MARK: Initializers

	init(
		edge: VerticalEdge,
		alignment: HorizontalAlignment = .center,
		spacing: CGFloat? = nil,
		toolbarBackgroundHidden: Bool = true,
		_ bar: Bar
	) {
		self.edge = edge
		self.alignment = alignment
		self.spacing = spacing
		self.toolbarBackgroundHidden = toolbarBackgroundHidden
		self.bar = bar
	}

	// MARK: View

	#if canImport(AppKit)
	func body(content: Content) -> some View {
		if #available(macOS 26.0, *) {
			content
				.safeAreaBar(edge: edge, alignment: alignment, spacing: spacing) {
					bar
				}
		} else {
			content
				.safeAreaInset(edge: edge, alignment: alignment, spacing: spacing) {
					bar
				}
		}
	}
	#endif

	#if canImport(UIKit)
	func body(content: Content) -> some View {
		if #available(iOS 26.0, *) {
			content
				.safeAreaBar(edge: edge, alignment: alignment, spacing: spacing) {
					bar
				}
				.navigationBarTitleDisplayMode(edge == .top ? .inline : .automatic)
		} else {
			content
				.safeAreaInset(edge: edge, alignment: alignment, spacing: spacing) {
					bar
						.background(.regularMaterial)
						.overlay(alignment: edge == .top ? .bottom : .top) {
							Divider()
						}
				}
				.toolbarBackgroundVisibility(toolbarBackgroundHidden ? .hidden : .automatic)
		}
	}
	#endif
}

extension View {
	/// Shows the specified content as a custom bar above or below the modified view.
	/// Uses `safeAreaBar` on macOS 26 Tahoe, iOS 26, iPadOS 26, watchOS 26, tvOS 26, and visionOS 26, and uses `safeAreaInset`
	/// as a fallback on earlier versions.
	///
	/// Similar to the `safeAreaInset(edge:alignment:spacing:content:)` modifier, the `bar` view is anchored to the specified vertical edge
	/// of the parent view and its height insets the safe area.
	///
	/// Additionally, it extends the edge effect of any scroll views affected by the inset safe area.
	/// - Parameters:
	///   - edge: The vertical edge of the view on which `bar` is placed.
	///   - alignment: The alignment guide used to position `bar` horizontally.
	///   - spacing: Extra distance placed between the two views, or nil to use the default amount of spacing.
	///   - toolbarBackgroundHidden: A Boolean value to specify whether to hide the background of the toolbar at the edge where `bar` is placed
	///   on platforms where `safeAreaBar` is not available.
	///   - bar: A view builder function providing the view to display as a custom bar.
	/// - Returns: A new view that displays `bar` above or below the modified view, making space for the `bar` view by vertically insetting the
	/// modified view, adjusting the safe area and scroll edge effects (if available) to match.
	func universalSafeAreaBar<Bar: View>(
		edge: VerticalEdge,
		alignment: HorizontalAlignment = .center,
		spacing: CGFloat? = nil,
		toolbarBackgroundHidden: Bool = true,
		@ViewBuilder _ bar: @escaping () -> Bar
	) -> some View {
		modifier(
			UniversalSafeAreaBar(
				edge: edge,
				alignment: alignment,
				spacing: spacing,
				toolbarBackgroundHidden: toolbarBackgroundHidden,
				bar()
			)
		)
	}
}
