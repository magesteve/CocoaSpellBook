//
//  SpellWrappedViewController.swift
//  CocoaSpellsBook
//
//  Created by Steve Sheets on 2/17/21.
//  Copyright © 2021 Steve Sheets. All rights reserved.
//

import Foundation
import Cocoa

// MARK: Class

/// Specialty class of view controller designed to wrap around a view programmically.
public class SpellWrappedViewController: NSViewController {
    
// MARK: Variables

    /// View to wrap around when view loaded. Must be set before loadView called.
    var viewHolder: NSView?
    
// MARK: Lifecycle

    override public func loadView() {
        if let v = viewHolder {
            self.view = v
        }
        
        viewHolder = nil
    }

}
