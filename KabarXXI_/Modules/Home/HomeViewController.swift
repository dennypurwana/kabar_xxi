

import UIKit
import CarbonKit
import GoogleMobileAds

class HomeViewController: UIViewController
, CarbonTabSwipeNavigationDelegate , GADInterstitialDelegate
{
   let items = ["Terbaru", "Berita Utama", "Berita Populer", "Opini","Tips"]
    
    
    var interstitial : GADInterstitial!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTabbarNews()
        interstitial = createAndLoadIntertitial()
        
        if interstitial.isReady {
            
            interstitial.present(fromRootViewController: self)
        
        }
        else {
            
            print("ads not ready")
        }
      
    }
    
    func createAndLoadIntertitial() -> GADInterstitial{
        
        var intertitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/3986624511")
        intertitial.delegate = self
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        intertitial.load(request)
        
        return intertitial
        
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadIntertitial()
    }
    
    func setupNavBar(){
        
            let logoImage = UIImage.init(named: "logo_kabar")
            let logoImageView = UIImageView.init(image: logoImage)
            logoImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 10)
            logoImageView.contentMode = .scaleAspectFit
            let imageItem = UIBarButtonItem.init(customView: logoImageView)
            let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            negativeSpacer.width = -25
            navigationItem.leftBarButtonItems = [negativeSpacer, imageItem]
        
    }
    
    
    func setupTabbarNews(){
        
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.setNormalColor(.darkGray)
        carbonTabSwipeNavigation.setSelectedColor(.black)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        
        if (index == 0){
            let newsLatest = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: "newsLatest")
            return newsLatest
        }
       
        else if (index == 1 ){
          
            let newsPremier = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: "newsPremier")
            return newsPremier
            
        }
            
        else if (index == 2 ){
            
            let newsPremier = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: "newsMostPopular")
            return newsPremier
            
        }
            
        else if (index == 3 ){
            
            let newsMostCommented = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: "newsMostCommented")
            return newsMostCommented
            
        }
            
        else {
            
            let newsTips = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: "newsTips")
            return newsTips
            
        }
        
        
    }
    
}
       
