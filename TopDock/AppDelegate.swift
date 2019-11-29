//
//  AppDelegate.swift
//  TopDock
//
//  Created by leng on 2019/11/28.
//  Copyright © 2019 leng. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        if let button = statusItem.button {
            let icon = NSImage.init(named: "statusbar")
            icon?.isTemplate = true
            button.image = icon
            button.target = self
            button.action = #selector(statusBarMouseClicked(sender:))
            button.sendAction(on: [.leftMouseUp])
        }
        
        let mainViewController = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "MainController") as! MainController

        popover.contentViewController = mainViewController
        popover.behavior = NSPopover.Behavior.transient
        
        
       eventMonitor = EventMonitor(mask: [NSEvent.EventTypeMask.leftMouseDown, NSEvent.EventTypeMask.rightMouseDown]) { [weak self] event in
           if let popover = self?.popover {
               if popover.isShown {
                   self?.closePopover(event)
               }
           }
       }
       eventMonitor?.start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    @objc private func statusBarMouseClicked(sender: NSStatusBarButton) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    
    private func showPopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            eventMonitor?.start()
        }
    }
    
    private func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
}

