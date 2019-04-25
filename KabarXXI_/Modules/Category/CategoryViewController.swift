import UIKit
import RxSwift
import Kingfisher
import UIScrollView_InfiniteScroll
import RealmSwift
import CoreSpotlight
import MobileCoreServices

class CategoryViewController: UIViewController , UICollectionViewDataSource {
  
    @IBOutlet var collectionViewCategory: UICollectionView!
   
    var refreshControl : UIRefreshControl!
    var categoryArray : [Category] = []
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Category"
        collectionViewCategory.delegate = self as? UICollectionViewDelegate
        collectionViewCategory.dataSource = self
       // setupViews()
       // refreshControl.beginRefreshing()
        loadCategories()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  loadCategories()
    }
    
    func loadCategories() {
        
        
        newsProviderServices.request(.getCategory()) { [weak self] result in
            guard case self = self else { return }
            
            // 3
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let responses = try decoder.decode(CategoryResponse.self, from:
                        response.data)
                    print(responses)
                    self?.categoryArray = responses.data
                    self?.collectionViewCategory.reloadData()
                    print("refreshhh category")
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            case .failure: break
            }
            
            self?.refreshControl?.endRefreshing()
            self?.collectionViewCategory.finishInfiniteScroll()
        }
        
    }
   
    @objc func refresh(_ sender: UIRefreshControl) {
        loadCategories()    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        let category_ = categoryArray[indexPath.row]
        print(category_.description)
        let imageUrl = Constant.ApiUrlImage+"\(category_.base64Image)"
        cell.categoryImage.kf.setImage(with: URL(string: imageUrl))
        cell.categoryLabel.text = category_.categoryName

        return cell
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryData = categoryArray[indexPath.item]
        showNewsByCategoryController(with: categoryData.categoryName )
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 3
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: size)
    }
    
}





//
//extension CategoryViewController : UICollectionViewDelegateFlowLayout {
//    //1
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //2
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - paddingSpace
//        let widthPerItem = availableWidth / itemsPerRow
//
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
//
//    //3
//    override func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//
//    // 4
//    override func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left
//    }
//}



