//
//  NSViewController+CocoaSpellsBook.swift
//  CocoaSpellsBook
//
//  Created by Steve Sheets on 1/25/21.
//  Copyright © 2021 Steve Sheets. All rights reserved.

import Foundation
import Cocoa
import SwiftSpellBook

import Foundation

// MARK: Extension

public extension NSViewController {

    // MARK: IBAction Functions

    /// Action to dismiss Modal with OK condition
    /// - Parameter sender: Object that invoked the function
    @IBAction func modalOkAction(_ sender: Any) {
        if let _ = NSApplication.shared.modalWindow {
            NSApplication.shared.stopModal(withCode: .OK)
        }
        else {
            guard let aWindow = self.view.window, let aParent = aWindow.sheetParent else { return }
            
            aParent.endSheet(aWindow, returnCode: .OK)
        }
    }

    /// Action to dismiss Modal with Cancel condition
    /// - Parameter sender: Object that invoked the function
    @IBAction func modalCancelAction(_ sender: Any) {
        if let _ = NSApplication.shared.modalWindow {
            NSApplication.shared.stopModal(withCode: .cancel)
        }
        else {
            guard let aWindow = self.view.window, let aParent = aWindow.sheetParent else { return }
            
            aParent.endSheet(aWindow, returnCode: .cancel)
        }
        
    }

}
