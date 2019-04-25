

import UIKit
import CarbonKit

class HomeViewController: UIViewController
, CarbonTabSwipeNavigationDelegate
{
   let items = ["Terbaru", "Berita Utama", "Berita Populer", "Opini","Tips"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTabbarNews()
        
      
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
       
