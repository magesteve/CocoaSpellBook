# CocoaSpellBook

[![Swift](https://img.shields.io/badge/Swift-5-blue.svg)](https://swift.org)
[![macOS](https://img.shields.io/badge/os-macOS-blue.svg)](https://apple.com/mac)
[![Xcode](https://img.shields.io/badge/Xcode-12-blue.svg)](https://developer.apple.com/xcode)
[![SPM](https://img.shields.io/badge/SPM-Compatible-blue)](https://swift.org/package-manager)
[![MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Swift Package of useful tools for Macintosh App development (Cocoa).

## Installation

### Requirements

- MacOS 10.15
- Swift 5
- Xcode 11

### Repository

  https://github.com/magesteve/CocoaSpellBook
  
## Documentation

Refer to inline documentation for explanation for specific calls.

### Closure Typealiases Magic

Typealiases for Closures.

For example, ImageClosure is a typealais for a Closure that has no results, but it passed a NSImage.

### Constants Magic

Extensions to the abstract structure CocoaSpellBook containing various Human Readable constants (using NSLocalizedString) and computed constants (reading from plist.info file).

### Panel Magic

Extensions to the abstract structure CocoaSpellBook to easily manage Save & Open Panels.  Some of the calls require Closures that will be invoked with the specific information (URL, Data, etc.), assuming the user has entered the correct information. 

For example, saveFile(data:,type:) is a function that displays a save panel to save given data as given file type. If new file is referenced, data is saved to that file.

### NSApp Magic

Extensions to the abstract structure CocoaSpellBook to open item external to the source code (URLs, embeded Files, Help manager).  

For example, openURL() is a function that is passed an URL, and invokes it (usually opening Safari).

### NSDocumentController Magic

Extensions to the abstract structure CocoaSpellBook providing NSDocumentController function including open document & new document.  Some of the function can be modified using the associated changable closure variable. 

### Alert & Modals Magic

Extensions to the abstract structure CocoaSpellBook to provide standard Alerts (message, yes/no, Are you sure) and processing of modal windows.

### SpellColorBackgroundView Magic

Custom NSView subclass SpellColorBackgroundView fills the view with either  with either specified NSColor, or using the Aqua safe colors controlBackgroundColor or unemphasizedSelectedContentBackgroundColor. The important fields are Inspectable by Interface Builder.

## Demo App

Sample code using this SpellBook can be found in the open-source Cocoa App [CocoaGrimoire](https://github.com/magesteve/CocoaGrimoire). Other SpellBooks by the author are also demonstrated there.

## License

CocoaSpellBook is available as open source under the terms of the [MIT](https://github.com/magesteve/CocoaSpellBook/blob/main/LICENSE) License.
