//
//  SpellColorBackgroundView.swift
//  CocoaSpellsBook
//
//  Created by Steve Sheets on 2/7/21.
//  Copyright © 2021 Steve Sheets. All rights reserved.
//

import Foundation
import Cocoa

// MARK: - Class

/// View subclass that fills with either specified NSColor, or using the Aqua safe colors controlBackgroundColor or unemphasizedSelectedContentBackgroundColor.
public class SpellColorBackgroundView: NSView {
    
    /// Optional Color to Draw in background
    @IBInspectable public var colorBackground: NSColor?

    /// Optional Color to Draw in background (using controlBackgroundColor)
    @IBInspectable public var normalBackground: Bool = false

    /// Optional Color to Draw in background (using unemphasizedSelectedContentBackgroundColor)
    @IBInspectable public var darkBackground: Bool = false

// MARK: Lifecyle
    
    override public func draw(_ dirtyRect: NSRect) {
        if let color = colorBackground {
            color.setFill()
        }
        else if normalBackground {
            NSColor.controlBackgroundColor.setFill()
        }
        else if darkBackground {
            NSColor.unemphasizedSelectedContentBackgroundColor.setFill()
        }
        else {
            NSColor.white.setFill()
        }

        self.bounds.fill()
    }

}

