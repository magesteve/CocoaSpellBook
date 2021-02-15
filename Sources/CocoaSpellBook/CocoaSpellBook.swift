//
//  CocoaSpells.swift
//  CocoaSpells
//
//  Created by Steve Sheets on 1/10/21.
//  Copyright © 2021 Steve Sheets. All rights reserved.

import Foundation
import Cocoa
import SwiftSpellBook

// MARK: - Protocols

/// Protocol to support having actions.
///
/// Types that support SlamActionable manage a closure that attempts some action, with an utility function to invoke the closure. It is comon to use this protocol on Button-like views.
public protocol SlamActionable {

    // MARK: - Required Properties
    
    /// Optional Pressed button action closure.
    var slamActionClosure: SwiftSpellBook.SimpleClosure? { get set }
    
}

/// Protocol to support that can input text
///
/// Types that support SlamTextInputable are visible objects that support having a closure to invoke when the string value is changed.  It is comon to use this protocol on views like NSText or NSTextField.
public protocol SlamTextInputable {

    // MARK: - Required Properties

    // state of text
    var slamTextState: String { get }

    /// Optional text change event
    var slamTextChangedEvent: SwiftSpellBook.StringClosure? { get set }

}

/// Protocol to support that can input integer value
///
/// Types that support SlamIntInputable are visible objects that support having a closure to invoke when the string value is changed.  It is comon to use this protocol on views like NSStepper.
public protocol SlamIntInputable {

    // MARK: - Required Properties

    // state of int
    var slamIntState: Int { get }

    /// Optional int change event
    var slamIntChangedEvent: SwiftSpellBook.IntClosure? { get set }

}

/// Protocol to support that can input Bool value
///
/// Types that support SlamSwitchable are visible objects that support having a closure to invoke when the bool value is changed.  It is comon to use this protocol on views like NSSwitch & NSCheckBox.
public protocol SlamSwitchable {

    // MARK: Required Properties
    
    // state of flag
    var slamSwitchState: Bool { get }

    /// Optional switch change event
    var slamSwitchChangedEvent: SwiftSpellBook.BoolClosure? { get set }

}

// MARK: - Structure
/// Abstract extension for name space of typealias & static functions.
public struct CocoaSpellBook {
    
}

// MARK: - Closure Typealiases

public extension CocoaSpellBook {
    /// Closure that has no results, but it passed a NSImage.
    typealias ImageClosure = (NSImage) -> Void

    /// Closure that has no parameters, but returns a NSImage.
    typealias imageSourceClosure = () -> NSImage

    /// Closure that has no results, but it passed a NSViewController.
    typealias viewControllerClosure = (NSViewController) -> Void

    /// Closure that has no parameters, but returns a NSViewController.
    typealias viewControllerSourceClosure = () -> NSViewController
}

// MARK: - Constants

public extension CocoaSpellBook {

    // MARK: - Phrases

    /// Human Readable phrase "OK"
    static let okPhrase = NSLocalizedString("OK", comment: "Standard OK word")

    /// Human Readable phrase "Cancel"
    static let cancelPhrase = NSLocalizedString("Cancel", comment: "Standard Cancel word")

    /// Human Readable phrase "Yes"
    static let yesPhrase = NSLocalizedString("Yes", comment: "Standard Yes word")

    /// Human Readable phrase "No""
    static let noPhrase = NSLocalizedString("No", comment: "Standard No word")

    /// Human Readable phrase "True"
    static let truePhrase = NSLocalizedString("True", comment: "Standard True word")

    /// Human Readable phrase "False""
    static let falsePhrase = NSLocalizedString("False", comment: "Standard False word")

    /// Human Readable phrase "Are you sure you wish to do this?"
    static let areYouSurePhrase = NSLocalizedString("Are you sure you wish to do this?", comment: "Standard question to verify are you sure")
    
    // MARK: - Info.plist Constants

    /// App Name (lazy)
    static var appName: String = {
        if let text = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            return text
        }

        if let text = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            return text
        }
        
        return ""
    }()
    
    /// App Version (lazy)
    static var appVersion: String = {
        guard let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return ""
        }

        return text
    }()
    
    /// App Copyright (lazy)
    static var appCopyright: String = {
        guard let text = Bundle.main.infoDictionary?["NSHumanReadableCopyright"] as? String else {
            return ""
        }
        
        return text
    }()

}

// MARK: - Open/Save Panel Extensions

public extension CocoaSpellBook {

    /// Invokes SavePanel for given file type.  If user enters path, closure is invoked with specified URL.
    static func saveFileURL(type: String, block: @escaping SwiftSpellBook.URLClosure) {
        let savePanel = NSSavePanel()
        
        savePanel.allowedFileTypes = [type]
        
        savePanel.begin { result in
            guard result.rawValue == NSApplication.ModalResponse.OK.rawValue,
                  let url = savePanel.url else { return }
            
            block(url)
        }
    }

    /// Invokes SavePanel for given file type.  If user enters path, given data is saved to specified URL.
    static func saveFile(data: Data, type: String) {
        CocoaSpellBook.saveFileURL(type: type) { url in
            let nsdata = data as NSData
            
            nsdata.write(to: url, atomically: false)
        }
    }
    
    /// Invokes SavePanel for given file type (default 'txt').  If user enters path, given string is saved to specified URL.
    static func saveFile(string: String, type: String = "txt") {
        let data = Data(string.utf8)
        
        CocoaSpellBook.saveFile(data: data, type: type)
    }
    
    /// Invokes SavePanel for JPEG images.  If user enters path, given image is saved to specified URL.
    static func saveFile(image: NSImage) {
        CocoaSpellBook.saveFileURL(type: "jpg") { url in
            guard let bits = image.representations.first as? NSBitmapImageRep,
                  let data = bits.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:]) else { return }
            
            let nsdata = data as NSData
            
            nsdata.write(to: url, atomically: false)
        }
    }

    /// Invokes SavePanel for given file type.  If user selecta a file, closure is invoked with specified URL.
    static func openFileURL(type: String, block: @escaping SwiftSpellBook.URLClosure ) {
        let openPanel = NSOpenPanel()
        
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = [type]
        
        openPanel.begin { result in
            guard result.rawValue == NSApplication.ModalResponse.OK.rawValue,
                  let url = openPanel.url else { return }
            
            block(url)
        }
    }

    /// Invokes SavePanel for given file type.  If user selecta a file, closure is invoked with data from specified URL.
    static func openFileData(type: String, block: @escaping SwiftSpellBook.DataClosure ) {
        CocoaSpellBook.openFileURL(type: type) { url in
            guard let data = try? Data(contentsOf: url) else { return }
            
            block(data)
       }
    }

    /// Invokes SavePanel for given file type (default 'txt').  If user selecta a file, closure is invoked with string from specified URL.
    static func openFileString(type: String = "txt", block: @escaping SwiftSpellBook.StringClosure ) {
        CocoaSpellBook.openFileData(type: type) { data in
            let string = String(decoding: data, as: UTF8.self)
            
            block(string)
       }
    }

    /// Invokes SavePanel for "jpg" file type.  If user selecta a file, closure is invoked with image from specified URL.
    static func openFileImage(block: @escaping ImageClosure ) {
        CocoaSpellBook.openFileURL(type: "jpg") { url in
            guard let image = NSImage(contentsOf: url) else { return }
            
            block(image)
       }
    }

}

// MARK: - NSApp Extensions

public extension CocoaSpellBook {
    
    /// Given string, open Safari with that Link
    /// - Parameter link: String text to open.
    static func openURL(_ link: String) {
        guard !link.isEmpty, let aURL = URL(string: link) else { return }
        
        NSWorkspace.shared.open(aURL)
    }

    /// Given string, open bundled file with that name
    /// - Parameter link: String File to open.
    static func openBundledFile(_ name: String) {
        guard !name.isEmpty, let aURL = Bundle.main.url(forResource: name, withExtension: "") else { return }
        
        NSWorkspace.shared.open(aURL)
    }
    
    /// Given string, open Help wtih that section
    /// - Parameter link: String Help to open.
    static func openHelp(_ name: String? = nil) {
        NSApplication.shared.showHelp(nil)

        guard let name = name, name.isNotEmpty else { return }
        
         NSHelpManager.shared.find(name, inBook: nil)
    }
    
}

// MARK: - NSDocumentController Extensions

public extension CocoaSpellBook {
    
    // MARK: - Static Variable Closures
    
    /// Closure for newDoc, default version invokes standardNewDoc()
    static var newDocAction: SwiftSpellBook.SimpleClosure = { CocoaSpellBook.standardNewDoc() }

    /// Closure for openDoc, default version invokes standardOpenDoc()
    static var openDocAction: SwiftSpellBook.SimpleClosure = { CocoaSpellBook.standardOpenDoc() }

    
    // MARK: - Static Functions
    
    /// Is the app designed for document editors
    static func isDocumentEditor() -> Bool {
        let dc = NSDocumentController.shared
        
        guard let _ = dc.defaultType else { return false }
    
        return true
    }
    
    /// New Document displayed
    /// Standard New Document Display
    static func standardNewDoc() {
        let dc = NSDocumentController.shared

        dc.newDocument(nil)
    }

    /// New Document displayed
    /// Standard New Document Display
    static func newDoc() {
        newDocAction()
    }
    
    /// Standard Open Document displayed
    static func standardOpenDoc() {
        let dc = NSDocumentController.shared

        dc.openDocument(nil)
    }
    
    /// Open Document displayed
    static func openDoc() {
        openDocAction()
    }
    
}

// MARK: - Alerts & Modals

public extension CocoaSpellBook {

    /// Run a window modally,. Depending if Ok or Cancel is pressed, the associated block is executed.
    static func modal(window: NSWindow, okAction: SwiftSpellBook.SimpleClosure? = nil, cancelAction: SwiftSpellBook.SimpleClosure? = nil) {
        window.center()

        let m = NSApplication.shared.runModal(for: window)
        
        window.orderOut(nil)

        if m == .OK {
            if let block = okAction {
                block()
            }
        }
        else if m == .cancel {
            if let block = cancelAction {
                block()
            }
        }
    }

    /// Alert for asking question. With Yes/No response expected
    /// - Parameters:
    ///   - text: String main text to display
    ///   - info: Optional String for info text
    ///   - iconName: Optional String for name of icon used
    ///   - critical: critical description
    ///   - ok: Optional String for OK button title
    static func standardMessage(_ text: String, info: String? = nil, iconName: String? = nil, critical:  Bool = false, okName: String = CocoaSpellBook.okPhrase) {
        let alert = NSAlert()
        alert.messageText = text
        if let info = info {
            alert.informativeText = info
        }
        if let iconName = iconName {
            if let icon = NSImage(named: iconName) {
                alert.icon = icon
            }
        }
        if critical {
            alert.alertStyle = .critical
        }
        alert.addButton(withTitle: okName)
        
        _ = alert.runModal()
    }

    /// Alert for asking question. With Yes/No response expected
    /// - Parameters:
    ///   - text: String main text to display
    ///   - info: Optional String for info text
    ///   - iconName: Optional String for name of icon used
    ///   - critical: critical description
    ///   - ok: Optional String for OK button title
    ///   - cancel: Optional String for Cancel button title
    /// - Returns: Bool true is user hit OK
    static func standardOKCancel(_ text: String, info: String? = nil, iconName: String? = nil, critical:  Bool = false, okName: String = CocoaSpellBook.okPhrase, cancelName: String = CocoaSpellBook.cancelPhrase) -> Bool {
        let alert = NSAlert()
        alert.messageText = text
        if let info = info {
            alert.informativeText = info
        }
        if let iconName = iconName {
            if let icon = NSImage(named: iconName) {
                alert.icon = icon
            }
        }
        if critical {
            alert.alertStyle = .critical
        }
        alert.addButton(withTitle: okName)
        alert.addButton(withTitle: cancelName)
        
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    /// Alert confirming you are sure. With Yes/No response expected
    /// - Parameter info: Optional String with info to add
    /// - Returns: Bool True if user selected yes
    static func standardAreYouSureMessage(info: String? = nil) -> Bool {
        return standardOKCancel(CocoaSpellBook.areYouSurePhrase, info: info, okName: CocoaSpellBook.yesPhrase, cancelName: CocoaSpellBook.noPhrase)

    }
}

// MARK: - Extensions

// Extenion to Bool
public extension Bool {
    
    /// Human Readable conversion of Bool to Yes/No
    var hrYesNo: String { self ? CocoaSpellBook.yesPhrase : CocoaSpellBook.noPhrase}

    /// Human Readable conversion of Bool to True/False
    var hrTrueFalse: String { self ? CocoaSpellBook.truePhrase : CocoaSpellBook.falsePhrase}
}

// Extension to SlamActionable
public extension SlamActionable {
    
    // MARK: - Public Functions
    
    /// Invoke Closure Action
    func slamPerformAction() {
        if let block = slamActionClosure {
            block()
        }
    }

}

// Extension to SlamTextInputable
public extension SlamTextInputable {
    
    // MARK: Public Functions

   /// Invoke text changed
    func slamTextChangedAction() {
        if let block = slamTextChangedEvent {
            block(slamTextState)
        }
    }

}

// Extension to SlamIntInputable
public extension SlamIntInputable {
    
    // MARK: Public Functions

   /// Invoke Int changed
    func slamIntChangedAction() {
        if let block = slamIntChangedEvent {
            block(slamIntState)
        }
    }

}

// Extension to SlamSwitchable
public extension SlamSwitchable {
    
    // MARK: Public Functions

   /// Invoke switch changed
    func slamSwitchChangedAction() {
        if let block = slamSwitchChangedEvent {
            block(slamSwitchState)
        }
    }

}

