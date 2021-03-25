//
//  NSWindowController+CocoaSpellsBook.swift
//  CocoaSpellsBook
//
//  Created by Steve Sheets on 2/17/21.
//  Copyright © 2021 Steve Sheets. All rights reserved.

import Foundation
import Cocoa
import SwiftSpellBook

import Foundation

// MARK: - Extension

public extension NSWindowController {

    /// Hide the window of controller by ordering it out.
    func spellHideWindow(_ sender: Any?) {
        window?.orderOut(sender)
    }

}
