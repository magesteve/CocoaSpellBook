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

// MARK: - Extension

public extension NSViewController {

    // MARK: - Functions

    /// Wrap the view controller into a Window, and wrap the window into a windowcontroller (that is returend. Title can be set.  The window can have/not have the buttons to control closing or resizing.
    func spellWrapWindowController(title: String?, resizeable: Bool = false, closeable: Bool = false) -> NSWindowController {
        let w = NSWindow(contentViewController: self)
        let wc = NSWindowController(window:w)
        
        if !resizeable {
            w.styleMask.remove( [ .resizable ] )
            w.styleMask.remove( [ .miniaturizable ] )
        }
        
        if !closeable {
            w.styleMask.remove( [ .closable ] )
        }
        
        if let title = title {
            w.title = title
        }
        else {
            w.styleMask.remove( [ .titled ] )
        }
        
        return wc
    }
    
    // MARK: - IBAction Functions

    /// Action to dismiss Modal with OK condition
    /// - Parameter sender: Object that invoked the function
    @IBAction func spellModalOkAction(_ sender: Any) {
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
    @IBAction func spellModalCancelAction(_ sender: Any) {
        if let _ = NSApplication.shared.modalWindow {
            NSApplication.shared.stopModal(withCode: .cancel)
        }
        else {
            guard let aWindow = self.view.window, let aParent = aWindow.sheetParent else { return }
            
            aParent.endSheet(aWindow, returnCode: .cancel)
        }
        
    }

}
