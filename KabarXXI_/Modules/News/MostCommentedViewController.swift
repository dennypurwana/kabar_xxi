import UIKit

class MostCommentedViewController: UITableViewController {

    @IBOutlet var mostCommentTableView: UITableView!
    
    var newsArray: [News] = []
    var refreshControl_: UIRefreshControl?
    var totalPage = 0
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        refreshControl_!.beginRefreshing()
        loadNews(page)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNews(page)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        
        loadNews(page)
        
    }
    
    
    func setupViews() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        mostCommentTableView.addSubview(refreshControl)
        self.refreshControl_ = refreshControl
        mostCommentTableView.addInfiniteScroll { (tipsTableView) in
            self.loadNews(self.page + 1)
        }
        
        mostCommentTableView.setShouldShowInfiniteScrollHandler { (tipsTableView) -> Bool in
            return self.page < self.totalPage
        }
        
    }
    
    func loadNews(_ page:Int) {
        newsProviderServices.request(.getNewsByCategory(page: page,categoryName: "Opini")) { [weak self] result in
            guard case self = self else { return }
            
            // 3
            switch result {
            case .success(let response):
                do {
                    
                    let decoder = JSONDecoder()
                    let responses = try decoder.decode(NewsResponse.self, from:
                        response.data)
                    
                    if page == 0 {
                        self?.newsArray = responses.data ?? []
                    }
                    else {
                        
                        self?.newsArray.append(contentsOf: responses.data ?? [])
                    }
                    
                    self?.totalPage = self?.newsArray.count ?? 0/10
                    self?.page = page
                    self?.mostCommentTableView.reloadData()
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            case .failure: break
            }
            
            self?.refreshControl_?.endRefreshing()
            self?.mostCommentTableView.finishInfiniteScroll()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.mostCommentTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        print("tes",indexPath.row)
        let cell = Bundle.main.loadNibNamed("NewsHeaderTableViewCell", owner: self, options: nil)?.first as! NewsHeaderTableViewCell
        
        let news_ = newsArray[indexPath.row]
        print(news_.title ?? "")
        let imageUrl = Constant.ApiUrlImage+"\(news_.base64Image  ?? "")"
        cell.imageNews.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "default_image"))
        cell.titleNews.text = news_.title
        cell.dateNews.text = news_.createdDate
        cell.totalViews.text = "\(news_.views!) dilihat"
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsData = newsArray[indexPath.item]
        
        showDetailNewsController(with: newsData.id ?? 0,with: newsData.title ?? "", with: newsData.createdDate ?? "", with: newsData.base64Image ?? "" , with: newsData.description ?? "",with:newsData.keyword ?? "",
            with:newsData.category?.categoryName ?? "")
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 250
        
    }

}
