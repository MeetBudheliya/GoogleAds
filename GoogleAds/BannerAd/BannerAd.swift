//
//  BannerAd.swift
//  GoogleAds
//
//  Created by Adsum MAC 1 on 05/07/21.
//

import UIKit
import GoogleMobileAds

class BannerAd: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // In this case, we instantiate the banner with desired ad size.
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
       
          bannerView.rootViewController = self
        bannerView.load(GADRequest())

    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
