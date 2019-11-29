//
//  AppCollectionViewItem.swift
//  TopDock
//
//  Created by leng on 2019/11/29.
//  Copyright © 2019 leng. All rights reserved.
//

import Cocoa

class AppCollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var icon: NSImageView!
    
    @IBOutlet weak var name: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
//        view.layer?.backgroundColor = NSColor.lightGray.cgColor
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
//        view.layer?.backgroundColor = NSColor.lightGray.cgColor
    }
    
    
    func setData(app: NSRunningApplication) {
        name.stringValue = app.localizedName ?? ""
        icon.image = app.icon
    }
    
}
