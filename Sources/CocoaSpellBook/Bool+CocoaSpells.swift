//
//  Bool+CocoaSpells.swift
//  CocoaSpells
//
//  Created by Steve Sheets on 1/10/21.
//  Copyright © 2021 Steve Sheets. All rights reserved.

import Foundation
import Cocoa

import Foundation

// MARK: - Extensions

// Extenion to Bool
public extension Bool {
    
    /// Human Readable conversion of Bool to Yes/No
    var spellYesNo: String { self ? CocoaSpellBook.yesPhrase : CocoaSpellBook.noPhrase}

    /// Human Readable conversion of Bool to True/False
    var spellTrueFalse: String { self ? CocoaSpellBook.truePhrase : CocoaSpellBook.falsePhrase}
}

