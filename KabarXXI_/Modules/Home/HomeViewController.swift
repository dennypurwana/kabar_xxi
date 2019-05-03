

import UIKit
import CarbonKit
import GoogleMobileAds
import Firebase

class HomeViewController: UIViewController
, CarbonTabSwipeNavigationDelegate , GADInterstitialDelegate, UISearchBarDelegate
{
    
    
   let items = ["Terbaru", "Berita Utama", "Berita Populer", "Opini","Info & Tips"]
    
    var interstitial : GADInterstitial!
    
    var searching = false
    var matches = [Int]()
    let searchBar:UISearchBar = UISearchBar(frame: CGRect(x:0,y:0,width: 300,height: 0))
    
    var searchActive : Bool = false
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var filtered:[String] = []
    
    var newsArray: [News] = []
    var totalPage = 0
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTabbarNews()
       
//        interstitial = createAndLoadIntertitial()
//
//        if interstitial.isReady {
//
//            interstitial.present(fromRootViewController: self)
//
//        }
//        else {
//
//            print("ads interstial not ready")
//        }
      
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    private func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    private func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("Search text \(searchText)")
       // loadNews(searchText)

    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
        interstitial = createAndLoadIntertitial()
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
        interstitial = createAndLoadIntertitial()
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadIntertitial()
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
        interstitial = createAndLoadIntertitial()
    }
    
    func loadNews(_ searchValue:String) {
        newsProviderServices.request(.searchNews(page: 0,searchValue: searchValue,categoryName: "all")) { [weak self] result in
            guard case self = self else { return }
            
            // 3
            switch result {
            case .success(let response):
                do {
                    
                    let decoder = JSONDecoder()
                    let responses = try decoder.decode(NewsResponse.self, from:
                        response.data)
                    
                    print("response search : \(responses)")
                    
        
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            case .failure: break
            }
            
        }
        
    }
    
    
    func createAndLoadIntertitial() -> GADInterstitial{
        
        let intertitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        intertitial.delegate = self
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        intertitial.load(request)
        
        return intertitial
        
    }
    

    
    func setupNavBar(){
        
           searchBar.delegate = self
            let logoImage = UIImage.init(named: "logo_kabar")
            let logoImageView = UIImageView.init(image: logoImage)
            logoImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
            logoImageView.contentMode = .scaleAspectFit
            let imageItem = UIBarButtonItem.init(customView: logoImageView)
            let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            negativeSpacer.width = -25
           self.navigationItem.leftBarButtonItems = [negativeSpacer, imageItem]
            searchBar.placeholder = "search news"
            let rightNavBarButton = UIBarButtonItem(customView:searchBar)
            self.navigationItem.rightBarButtonItem = rightNavBarButton
        
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
            
            let newsTips = UIStoryboard(name: "News", bundle: nil).instantiateViewController(withIdentifier: "categoryNews")
            return newsTips
            
        }
        
        
    }
    
}
       
