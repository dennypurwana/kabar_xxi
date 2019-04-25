
import UIKit

class NewsCommentViewController: UIViewController
  , UITableViewDataSource, UITableViewDelegate
  {
    
    @IBOutlet var newsCommentTableView: UITableView!
    
    var newsArray: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNews()
    }
    
    func loadNews() {
         let page:Int = 0
        newsProviderServices.request(.getLatestNews(page)) { [weak self] result in
            guard case self = self else { return }
            
            // 3
            switch result {
            case .success(let response):
                do {
                    
                    let decoder = JSONDecoder()
                    let responses = try decoder.decode(NewsResponse.self, from:
                        response.data)
                    print(responses)
                    self?.newsArray = responses.data
                    self?.newsCommentTableView.reloadData()
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            case .failure: break
            }
            
            //self?.refreshControl_?.endRefreshing()
            self?.newsCommentTableView.finishInfiniteScroll()
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.newsCommentTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        let cell = Bundle.main.loadNibNamed("NewsRelatedItemViewCell", owner: self, options: nil)?.first as! NewsRelatedItemViewCell
        
        let news_ = newsArray[indexPath.row]
        cell.titleNews.text = news_.title
        cell.dateNews.text = news_.createdDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
    
    
    
}
