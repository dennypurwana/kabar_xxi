

import UIKit
import CarbonKit

class HomeViewController: UIViewController
, CarbonTabSwipeNavigationDelegate
{
   let items = ["Terbaru", "Berita Utama", "Most Popular", "Most Commented","Tips"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "KabarXXI"
       
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
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
       
