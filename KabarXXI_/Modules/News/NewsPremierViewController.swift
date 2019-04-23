
import UIKit

class NewsPremierViewController: UITableViewController {

    @IBOutlet var newsPremierTableView: UITableView!
    
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
        
        newsProviderServices.request(.getMainNews()) { [weak self] result in
            guard case self = self else { return }
            
            // 3
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let responses = try decoder.decode(NewsResponse.self, from:
                        response.data)
                    self?.newsArray = responses.data
                    self?.newsPremierTableView.reloadData()
                    print("refreshhh")
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            case .failure: break
            }
            
            self?.refreshControl?.endRefreshing()
            self?.newsPremierTableView.finishInfiniteScroll()
        }
        
    }
    
    
    @objc func refresh(_ sender: UIRefreshControl) {
        loadNews()    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            self.newsPremierTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            print("tes",indexPath.row)
            let cell = Bundle.main.loadNibNamed("NewsHeaderTableViewCell", owner: self, options: nil)?.first as! NewsHeaderTableViewCell
            
            let news_ = newsArray[indexPath.row]
            print(news_.title)
            let imageUrl = Constant.ApiUrlImage+"\(news_.base64Image)"
            cell.imageNews.kf.setImage(with: URL(string: imageUrl))
            cell.titleNews.text = news_.title
            cell.dateNews.text = news_.createdDate
            
            return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsData = newsArray[indexPath.item]
        
        showDetailNewsController(with: newsData.title, with: newsData.createdDate, with: newsData.base64Image, with: newsData.description,with:newsData.keyword)
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 200
        
    }
    

 

}
