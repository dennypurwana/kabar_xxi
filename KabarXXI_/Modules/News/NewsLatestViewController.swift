
import UIKit
import RxSwift
import Kingfisher
import UIScrollView_InfiniteScroll
import RealmSwift
import CoreSpotlight
import MobileCoreServices
class NewsLatestViewController: UITableViewController {

    @IBOutlet var newsTableView: UITableView!
    
     var newsArray: [News] = []
    
     var refreshControl_: UIRefreshControl?
    
     let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        refreshControl_!.beginRefreshing()
        loadNews()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNews()
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
       
        loadNews()
        
    }
    
    func setupViews() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        newsTableView.addSubview(refreshControl)
        self.refreshControl_ = refreshControl
        self.loadNews()
    }
    
    func loadNews() {
        
        newsProviderServices.request(.getLatestNews()) { [weak self] result in
            guard case self = self else { return }
            
            // 3
            switch result {
            case .success(let response):
                do {
                    
//                    let jsonResponse = try JSONSerialization.jsonObject(with:
//                        response.data, options: [])
//                    print(jsonResponse)
                    //Response result
                    let decoder = JSONDecoder()
                    let responses = try decoder.decode(NewsResponse.self, from:
                        response.data)
                    self?.newsArray = responses.data
                    self?.newsTableView.reloadData()
                    print("refreshhh")
                 
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            case .failure: break
            }
            
            self?.refreshControl_?.endRefreshing()
            self?.newsTableView.finishInfiniteScroll()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
       if  indexPath.row == 0 {
            
            self.newsTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            print("tes",indexPath.row)
            let cell = Bundle.main.loadNibNamed("NewsHeaderTableViewCell", owner: self, options: nil)?.first as! NewsHeaderTableViewCell
            
            let news_ = newsArray[indexPath.row]
            print(news_.title)
            let imageUrl = Constant.ApiUrlImage+"\(news_.base64Image)"
            cell.imageNews.kf.setImage(with: URL(string: imageUrl))
            cell.titleNews.text = news_.title
            cell.dateNews.text = news_.createdDate
            
            return cell
            
        } else {
            
        self.newsTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        
        print("tes > 0",newsArray.count)
        let cell = Bundle.main.loadNibNamed("NewsItemTableViewCell", owner: self, options: nil)?.first as! NewsItemTableViewCell
        
        let news_ = newsArray[indexPath.row]
        print(news_.title)
        let imageUrl = Constant.ApiUrlImage+"\(news_.base64Image)"
        cell.imageNews.kf.setImage(with: URL(string: imageUrl))
        cell.titleNews.text = news_.title
        cell.dateNews.text = news_.createdDate
        
        return cell
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsData = newsArray[indexPath.item]
        
        showDetailNewsController(with: newsData.title, with: newsData.createdDate, with: newsData.base64Image, with: newsData.description)
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if  indexPath.row == 0 {
            return 250
            
        }
        else  {
            return 100
        }
    }
    


}


extension UIViewController {
    
    func showLatestViewController() {
        
        let storyboard = UIStoryboard(name: "News", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newsLatest") as! NewsLatestViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
    

