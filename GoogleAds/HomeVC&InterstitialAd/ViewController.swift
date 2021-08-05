//
//  ViewController.swift
//  GoogleAds
//
//  Created by Adsum MAC 1 on 05/07/21.
//

import UIKit
import GoogleMobileAds
class ViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    let adsData = ["Banner Ads","Interstitial ads","Native Ads","Rewarded ads","Rewarded interstitial"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionSetup()
    }
    func collectionSetup(){
        collection.delegate = self
        collection.dataSource = self
    }
    
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.bgView.layer.cornerRadius = 15
        cell.bgView.layer.shadowColor = UIColor.black.cgColor
        cell.bgView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.bgView.layer.shadowRadius = 7
        cell.bgView.layer.shadowOpacity = 0.5
        cell.lbl.text = adsData[indexPath.row]
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BannerAd") as! BannerAd
            self.navigationController?.present(vc, animated: true, completion: nil)
        }else if indexPath.row == 1{
            InterstitialAdSetup()
        }else if indexPath.row == 2{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NativeAd") as! NativeAd
            self.navigationController?.present(vc, animated: true, completion: nil)
        }else if indexPath.row == 3{
            loadRewardedAd()
        }else if indexPath.row == 4{
            loadRewardedInterestitalAd()
        }
    }
    
}

//MARK:- InterstitialAd
extension ViewController:GADFullScreenContentDelegate{
    func InterstitialAdSetup(){
        
            GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",request: GADRequest(),completionHandler: {ad, error in
                if let error = error {
                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
                }
                ad?.fullScreenContentDelegate = self
                ad?.present(fromRootViewController: self)
            }
            )
    }
}

//MARK:- Rewarded Ad
extension ViewController{
    func loadRewardedAd() {
        
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-3940256099942544/1712485313", request: GADRequest()) { ad, errr in
            guard errr == nil else{
                print(errr?.localizedDescription as Any)
                return
            }
            print(ad as Any)
            ad?.present(fromRootViewController: self, userDidEarnRewardHandler: {
                print("done")
            })
            ad?.fullScreenContentDelegate = self
            print(ad?.adReward.type as Any)
            print(ad?.adReward.amount as Any)
        }
    }
}


//MARK:- RewardedInterstitial Ad
extension ViewController{
    func loadRewardedInterestitalAd() {
        
        GADRewardedInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/1712485313", request: GADRequest()) { ad, errr in
            guard errr == nil else{
                print(errr?.localizedDescription as Any)
                return
            }
            print(ad as Any)
            ad?.present(fromRootViewController: self, userDidEarnRewardHandler: {
                print("done")
            })
            ad?.fullScreenContentDelegate = self
            print(ad?.adReward.type as Any)
            print(ad?.adReward.amount as Any)
        }
        
        
    }
}
