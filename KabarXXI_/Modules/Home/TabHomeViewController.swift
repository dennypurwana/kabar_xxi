import Foundation
import UIKit
import CarbonKit
class TabHomeViewController: ViewController , CarbonTabSwipeNavigationDelegate{
   
    
    
    @IBOutlet var buttonBar: UICollectionView!
    @IBOutlet var containerHomeView: UIScrollView!
    
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    let graySpotifyColor = UIColor(red: 21/255.0, green: 21/255.0, blue: 24/255.0, alpha: 1.0)
    let darkGraySpotifyColor = UIColor(red: 19/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1.0)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = ["Features", "Products", "About"]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
      
        
        
    }
    
    
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        let child_1 = UIStoryboard(name: "testTableLayout", bundle: nil).instantiateViewController(withIdentifier: "child1")
        
        return child_1
    }
    
    
}
