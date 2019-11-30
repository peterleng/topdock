//
//  ViewController.swift
//  TopDock
//
//  Created by leng on 2019/11/28.
//  Copyright © 2019 leng. All rights reserved.
//

import Cocoa

fileprivate let itemIdentifier = "AppCollectionViewItem"

class MainController: NSViewController {

    @IBOutlet weak var visualEffectView: NSVisualEffectView!
    @IBOutlet weak var collectionView: NSCollectionView!

    @IBOutlet weak var flowLayout: NSCollectionViewFlowLayout!

    fileprivate var runningApp: [NSRunningApplication] {
        get {
            NSWorkspace.shared.runningApplications.filter { (app) -> Bool in
                app.activationPolicy == .regular
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let _screen = NSScreen.main {
            if let imageURL = NSWorkspace.shared.desktopImageURL(for: _screen) {
                visualEffectView.maskImage = NSImage.init(contentsOf: imageURL)
            }
        }

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AppCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier.init(itemIdentifier))
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        collectionView.reloadData()
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

extension MainController: NSCollectionViewDelegate, NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        runningApp.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let cell: AppCollectionViewItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.init(itemIdentifier), for: indexPath) as! AppCollectionViewItem
        cell.setData(app: runningApp[indexPath.item])
        return cell
    }

    public func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if let _ = indexPaths.first {
            if let _ = runningApp[indexPaths.first!.item].bundleURL {
                NSWorkspace.shared.open(runningApp[indexPaths.first!.item].bundleURL!)
            }
        }

    }
}

