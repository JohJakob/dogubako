//
//  NSImage+Extensions.swift
//  dogubako
//
//  Created by Johannes Jakob on 07/07/2025
//

#if canImport(AppKit)

import AppKit

extension NSImage {
    /// Returns the flipped version of an image.
    /// - Parameters:
    ///   - horizontal: Flip the image horizontally (around the y axis).
    ///   - vertical: Flip the image vertically (around the x axis).
    /// - Returns: The flipped version of the image.
    public func flipped(horizontal: Bool = false, vertical: Bool = false) -> NSImage {
        let flippedImage = NSImage(size: size, flipped: false) { [self] rect in
            NSGraphicsContext.saveGraphicsState()

            let transform = NSAffineTransform()
            transform.translateX(by: horizontal ? size.width : 0, yBy: vertical ? size.height : 0)
            transform.scaleX(by: horizontal ? -1 : 1, yBy: vertical ? -1 : 1)
            transform.concat()

            draw(in: rect, from: .zero, operation: .sourceOver, fraction: 1)

            NSGraphicsContext.restoreGraphicsState()

            return true
        }

        flippedImage.isTemplate = isTemplate

        return flippedImage
    }
}

#endif
