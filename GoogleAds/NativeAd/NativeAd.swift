//
//  NativeAd.swift
//  GoogleAds
//
//  Created by Adsum MAC 1 on 05/07/21.
//

import UIKit
import GoogleMobileAds

class NativeAd: UIViewController,GADNativeAdDelegate{
    
    
    @IBOutlet weak var refreshAdButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var subHead: UILabel!
    @IBOutlet weak var mediaCollection: UICollectionView!
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var installBTN: UIButton!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var storeLBL: UILabel!
    
    var Images = [GADNativeAdImage]()
    var adLoader: GADAdLoader!
    let adUnitID = "ca-app-pub-3940256099942544/3986624511"
    
    /// The native ad view that is being presented.
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        refreshAd(nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func refreshAd(_ sender: AnyObject!) {
        refreshAdButton.isEnabled = false
        installBTN.isEnabled = false
        adLoader = GADAdLoader(
            adUnitID: adUnitID, rootViewController: self,
            adTypes: [.native], options: nil)
        adLoader.delegate = self
        adLoader.load(GADRequest())
    }
    
    func imageOfStars(from starRating: NSDecimalNumber?) -> UIImage? {
      guard let rating = starRating?.doubleValue else {
        return nil
      }
      if rating == 5 {
        return UIImage(named: "stars_5")
      } else if rating >= 4 {
        return UIImage(named: "stars_4")
      } else if rating >= 3 {
        return UIImage(named: "stars_3")
      } else if rating >= 2 {
        return UIImage(named: "stars_2")
      } else if rating >= 1 {
        return UIImage(named: "stars_1")
      } else {
        return nil
      }
    }
    
}
extension NativeAd: GADNativeAdLoaderDelegate {
    
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        refreshAdButton.isEnabled = true
        installBTN.isEnabled = true
        nativeAd.delegate = self
        
        image.image = nativeAd.icon?.image
        heading.text = nativeAd.headline
        subHead.text = nativeAd.body
        priceLBL.text = nativeAd.price
        installBTN.setTitle(nativeAd.callToAction, for: .normal)
        storeLBL.text = nativeAd.store
        ratingImage.image = imageOfStars(from: nativeAd.starRating)
        print(nativeAd.starRating)
        if let imgs = nativeAd.images{
            Images = imgs
            self.mediaCollection.reloadData()
        }
        
    
    }
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
extension NativeAd:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionSetup(){
        mediaCollection.delegate = self
        mediaCollection.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mediaCollection.dequeueReusableCell(withReuseIdentifier: "mediaCollection", for: indexPath) as! mediaCollection
        cell.img.image = Images[indexPath.row].image
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mediaCollection.bounds.width, height: mediaCollection.bounds.height)
    }
    
}
