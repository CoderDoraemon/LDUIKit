//
//  NSImage+.swift
//  SwiftyExts
//
//  Created by LDD on 2019/10/7.
//

#if canImport(AppKit)
import AppKit
import CoreImage

public extension NSImage {
    
    func ciImage() -> CIImage? {
        return tiffRepresentation(using: .none, factor: 0).flatMap(CIImage.init)
    }

    func cgImage() -> CGImage? {
        return cgImage(forProposedRect: nil, context: nil, hints: nil) ?? ciImage()?.cgImage()
    }
}
#endif
