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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AppCollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier.init(itemIdentifier))
//        collectionView.register(AppCollectionViewItem.classForCoder(), forSupplementaryViewOfKind: NSCollectionView.elementKindSectionFooter, withIdentifier: NSUserInterfaceItemIdentifier.init("AppCollectionViewFooter"))
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
//
//
//    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
//        print(indexPaths)
//    }
}

