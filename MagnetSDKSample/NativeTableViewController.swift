//
//  NativeTableViewController.swift
//  MagnetSDKSample
//
//  Created by Saeed on 1/4/17.
//  Copyright © 2017 Magnet. All rights reserved.
//

import UIKit
import MagnetSDK

class NativeTableViewController: UITableViewController, MagnetEventsDelegate {
    
    // MARK: - Properties
    
    private var tableViewItems = [AnyObject]()
    private var adsToLoad = [MagnetAdNative]()
    private var loadStateForAds = [MagnetAdNative:Bool]()
    private var adInterval = UIDevice.current.userInterfaceIdiom == .pad ? 10 : 5
    
    // MARK: - Load Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        addPostItems()
        adMagnetNativeAds()
        preloadNextAd()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let tableItem = tableViewItems[indexPath.row] as? MagnetAdNative {
            let isAdLoaded = loadStateForAds[tableItem]
            return isAdLoaded == true ? UITableViewAutomaticDimension : 0
        }
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let magnetAdnative = tableViewItems[indexPath.row] as? MagnetAdNative {
            
            let reusableAdCell = tableView.dequeueReusableCell(withIdentifier: "AdCell", for: indexPath) as! AdViewCell

            magnetAdnative.viewBinder(builder: { (binder) in
                binder.iconImage = reusableAdCell.adIcon
                binder.headLineLabel = reusableAdCell.adTitle
                binder.descriptionLabel = reusableAdCell.adDescription
                binder.actionButton = reusableAdCell.adButton
                binder.mainImage = reusableAdCell.adPicture
            })
            
            return reusableAdCell
            
        } else {
            
            let menuItem = tableViewItems[indexPath.row] as? PostItem
            
            let reusablePostItemCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemViewCell
            reusablePostItemCell.itemTitle.text = menuItem?.name
            reusablePostItemCell.itemDescription?.text = menuItem?.description
            reusablePostItemCell.itemPicture.image = menuItem?.photo
            
            return reusablePostItemCell
        }
    }
    
    // MARK: - Load Data
    
    func preloadNextAd() {
        if !adsToLoad.isEmpty {
            let magnetAd = adsToLoad.removeFirst()
            magnetAd.loadRequest(adUnitId: "0ed6ce11664e48ac9cc8982f2fcbca3a", delegate: self)
        }
    }
    
    func adMagnetNativeAds() {
        var index = adInterval
        while index < tableViewItems.count {
            let magnetAd = MagnetAdNative()
            tableViewItems.insert(magnetAd, at: index)
            adsToLoad.append(magnetAd)
            loadStateForAds[magnetAd] = false
            
            index += adInterval
        }
    }
        
    func addPostItems() {
        var JSONObject: Any
        
        guard let path = Bundle.main.url(forResource: "itemsJSON", withExtension: "json") else {
                print("Invalid filename for JSON menu item data.")
                return
        }
        
        do {
            let data = try Data(contentsOf: path)
            JSONObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
        } catch {
            print("Failed to load menu item JSON data: %s", error)
            return
        }
        
        guard let JSONObjectArray = JSONObject as? [Any] else {
            print("Failed to cast JSONObject to [AnyObject]")
            return
        }
        
        for object in JSONObjectArray {
            guard let dict = object as? [String: Any],
                let menuIem = PostItem(dictionary: dict) else {
                    print("Failed to load menu item JSON data.")
                    return
            }
            tableViewItems.append(menuIem)
        }
    }
    
    // MARK: - Magnet Event Delegates
    
    func magnetAdNativeDidReceive(magnetAdNative: MagnetAdNative) {
        loadStateForAds[magnetAdNative] = true
        preloadNextAd()
    }
    
    func magnetAdErrors(code: Int, message: String, adType: MagnetAdType) {
        print("\(Date().now) Magnet ERROR: \(adType) -> \(code): \(message)")
        preloadNextAd()
    }
    
    
}
