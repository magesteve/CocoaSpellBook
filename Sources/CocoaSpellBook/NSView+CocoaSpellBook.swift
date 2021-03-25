//
//  NSView+CocoaSpellsBook.swift
//  CocoaSpellsBook
//
//  Created by Steve Sheets on 2/17/21.
//  Copyright © 2021 Steve Sheets. All rights reserved.

import Foundation
import Cocoa
import SwiftSpellBook

import Foundation

// MARK: - Extension

public extension NSView {
    
    // MARK: - Functions

    /// Wrap the view inside a view controller, then wrap controller into a Window, and wrap the window into a windowcontroller (that is returend. Title can be set.  The window can have/not have the buttons to control closing or resizing.
    func spellWrapWindowController(title: String?, resizeable: Bool = false, closeable: Bool = false) -> NSWindowController {
        let vc = SpellWrappedViewController()
        vc.viewHolder = self
        
        return vc.spellWrapWindowController(title: title, resizeable: resizeable, closeable: closeable)
    }
    
    /// Set the horizontal window constraint of the view to this value.
    func spellSetContraint(width: CGFloat) {
        let constraints = [
            self.widthAnchor.constraint(equalToConstant: width)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Set the vertical window constraint of the view to this value.
    func spellSetContraint(height: CGFloat) {
        let constraints = [
            self.heightAnchor.constraint(equalToConstant: height)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Wrap the view inside another view, with constraints to sueprview is slightly larger than view..
    func spellWrapIndentView(space: CGFloat) -> NSView {
        var frame = self.bounds
        frame.size.width = frame.size.width + (2*space)
        frame.size.height = frame.size.height + (2*space)
        let view = NSView(frame: frame)
        
        view.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: space),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -space)
        ])
        
        return view
    }

}
