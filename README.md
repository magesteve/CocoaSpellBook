# CocoaSpellBook

Swift Package of useful tools for Cocoa Development.

https://github.com/magesteve/CocoaSpellBook

Refer to code documentation for explanation for specific calls.

## Closure Typealiases Magic

Typealiases for Closures.

For example, ImageClosure is a typealais for a Closure that has no results, but it passed a NSImage.

## Constants Magic

Extensions to the abstract structure CocoaSpellBook containing various Human Readable constants (using NSLocalizedString) and computed constants (reading from plist.info file).

## Panel Magic

Extensions to the abstract structure CocoaSpellBook to easily manage Save & Open Panels.  Some of the calls require Closures that will be invoked with the specific information (URL, Data, etc.), assuming the user has entered the correct information. 

For example, saveFile(data:,type:) is a function that displays a save panel to save given data as given file type. If new file is referenced, data is saved to that file.

## NSApp Magic

Extensions to the abstract structure CocoaSpellBook to open item external to the source code (URLs, embeded Files, Help manager).  

For example, openURL() is a function that is passed an URL, and invokes it (usually opening Safari).

## NSDocumentController Magic

Extensions to the abstract structure CocoaSpellBook providing NSDocumentController function including open document & new document.  Some of the function can be modified using the associated changable closure variable. 

## Alert & Modals Magic

Extensions to the abstract structure CocoaSpellBook to provide standard Alerts (message, yes/no, Are you sure) and processing of modal windows.
