// PanelSpells.swift

import Foundation
import Cocoa

public struct SpellBook {
    
    /// Closure that has no results, but it passed a URL.
    public typealias URLClosure = (URL) -> Void
    
    /// Closure that has no results, but it passed a Data.
    public typealias DataClosure = (Data) -> Void
    
    /// Closure that has no results, but it passed a String.
    public typealias StringClosure = (String) -> Void
    
    /// Closure that has no results, but it passed a NSImage.
    public typealias ImageClosure = (NSImage) -> Void
    
}


public extension SpellBook {

    /// Invokes SavePanel for given file type.  If user enters path, closure is invoked with specified URL.
    static func saveFileURL(type: String, block: @escaping URLClosure) {
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
        SpellBook.saveFileURL(type: type) { url in
            let nsdata = data as NSData
            
            nsdata.write(to: url, atomically: false)
        }
    }
    
    /// Invokes SavePanel for given file type (default 'txt').  If user enters path, given string is saved to specified URL.
    static func saveFile(string: String, type: String = "txt") {
        let data = Data(string.utf8)
        
        SpellBook.saveFile(data: data, type: type)
    }
    
    /// Invokes SavePanel for JPEG images.  If user enters path, given image is saved to specified URL.
    static func saveFile(image: NSImage) {
        SpellBook.saveFileURL(type: "jpg") { url in
            guard let bits = image.representations.first as? NSBitmapImageRep,
                  let data = bits.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:]) else { return }
            
            let nsdata = data as NSData
            
            nsdata.write(to: url, atomically: false)
        }
    }

    /// Invokes SavePanel for given file type.  If user selecta a file, closure is invoked with specified URL.
    static func openFileURL(type: String, block: @escaping URLClosure ) {
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
    static func openFileData(type: String, block: @escaping DataClosure ) {
        SpellBook.openFileURL(type: type) { url in
            guard let data = try? Data(contentsOf: url) else { return }
            
            block(data)
       }
    }

    /// Invokes SavePanel for given file type (default 'txt').  If user selecta a file, closure is invoked with string from specified URL.
    static func openFileString(type: String, block: @escaping StringClosure ) {
        SpellBook.openFileData(type: type) { data in
            let string = String(decoding: data, as: UTF8.self)
            
            block(string)
       }
    }

    /// Invokes SavePanel for "jpg" file type.  If user selecta a file, closure is invoked with image from specified URL.
    static func openFileImage(block: @escaping ImageClosure ) {
        SpellBook.openFileURL(type: "jpg") { url in
            guard let image = NSImage(contentsOf: url) else { return }
            
            block(image)
       }
    }

}

