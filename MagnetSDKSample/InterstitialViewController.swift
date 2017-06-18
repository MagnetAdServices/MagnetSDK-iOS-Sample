//
//  InterstitialViewController.swift
//  MagnetSDKSample
//
//  Created by Saeed Eskafi on 1/15/17.
//  Copyright © 2017 Magnet. All rights reserved.
//

import UIKit
import MagnetSDK

class InterstitialViewController: UIViewController, MagnetEventsDelegate {
    
    // MARK: Properties
    @IBOutlet weak var rewardResult: UILabel!
    @IBOutlet weak var showInterstitialButton: UIButton!
    @IBOutlet weak var showRewardButton: UIButton!
    
    private var magnetAdInterstitial = MagnetAdInterstitial()
    private var magnetAdReward = MagnetAdReward()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    // MARK: - InterstitialAd Handle
    @IBAction func loadInterstitial(_ sender: UIButton) {
        showInterstitialButton.isEnable = false
        magnetAdInterstitial.loadRequest(adUnitId: "0ed6ce11664e48ac9cc8982f2fcbca3a", delegate: self)
    }
    
    @IBAction func showInterstitial(_ sender: UIButton) {
        if magnetAdInterstitial.isReady {
            showInterstitialButton.isEnable = false
            magnetAdInterstitial.present(rootViewController: self)
        }
    }
    
    // MARK: MagnetAd Interstitial Delegate
    func magnetAdInterstitialDidReceive() {
        showInterstitialButton.isEnable = true
    }
    
    func magnetAdInterstitialDidClose() {
        print("MagnetAdInterstitial Controler is Closed!")
    }
    
    // MARK: - RewardAd Handle
    @IBAction func loadReward(_ sender: UIButton) {
        showRewardButton.isEnable = false
        magnetAdReward.loadRequest(adUnitId: "0ed6ce11664e48ac9cc8982f2fcbca3a", delegate: self)
    }
    
    @IBAction func showReward(_ sender: UIButton) {
        if magnetAdReward.isReady {
            showRewardButton.isEnable = false
            magnetAdReward.present(rootViewController: self)
        }
    }

    // MARK: Magnet Ad Reward Delegates
    func magnetAdRewardDidReceive() {
        showRewardButton.isEnable = true
    }
    
    func magnetAdRewardDidSuccess(verificationToken: String, trackingId: String) {
        rewardResult.textColor = UIColor.green
        rewardResult.text = "Reward Result: Success!"
        print("verificationToken: \(verificationToken), trackingId: \(trackingId)")
    }
    
    func magnetAdRewardDidFaild() {
        rewardResult.textColor = UIColor.red
        rewardResult.text = "Reward Result: Faild!"
    }
    
    func magnetAdRewardDidClose() {
        print("MagnetAdReward Controler is Closed!")
    }
    
    // MARK: - Magnet Ad Errors Delegate
    func magnetAdErrors(code: Int, message: String, adType: MagnetAdType) {
        print("\(Date().now) Magnet ERROR: \(adType) -> \(code): \(message)")
    }
}
