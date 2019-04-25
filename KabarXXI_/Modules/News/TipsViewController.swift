//
//  TipsViewController.swift
//  KabarXXI_
//
//  Created by Emerio-Mac2 on 18/04/19.
//  Copyright © 2019 Emerio-Mac2. All rights reserved.
//

import UIKit

class TipsViewController: UITableViewController {

    @IBOutlet var tipsTableView: UITableView!
    
    var newsArray: [News] = []
    var category:String = "tips"
    var refreshControl_: UIRefreshControl?
    var totalPage = 0
    var page = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        refreshControl_!.beginRefreshing()
        loadNews(page)
        
        if (category != "tips"){
            self.navigationItem.title = category
        }
        
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
        tipsTableView.addSubview(refreshControl)
        self.refreshControl_ = refreshControl
        tipsTableView.addInfiniteScroll { (tipsTableView) in
            self.loadNews(self.page + 1)
        }
        
        tipsTableView.setShouldShowInfiniteScrollHandler { (tipsTableView) -> Bool in
            return self.page < self.totalPage
        }
        
        
        
        // self.loadNews()
    }
    
    func loadNews(_ page:Int) {
        newsProviderServices.request(.getNewsByCategory(page: page,categoryName: category)) { [weak self] result in
            guard case self = self else { return }
            
            // 3
            switch result {
            case .success(let response):
                do {
                    
                    let decoder = JSONDecoder()
                    let responses = try decoder.decode(NewsResponse.self, from:
                        response.data)
                    
                    if page == 0 {
                        self?.newsArray = responses.data
                    }
                    else {
                        self?.newsArray.append(contentsOf: responses.data)
                    }
                    
                    self?.totalPage = self?.newsArray.count ?? 0/10
                    self?.page = page
                    self?.tipsTableView.reloadData()
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            case .failure: break
            }
            
            self?.refreshControl_?.endRefreshing()
            self?.tipsTableView.finishInfiniteScroll()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tipsTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
       
        if (self.category == "tips"){
            
        let cell = Bundle.main.loadNibNamed("NewsItemTableViewCell", owner: self, options: nil)?.first as! NewsItemTableViewCell
        
        let news_ = newsArray[indexPath.row]
        print(news_.title as Any)
        let imageUrl = Constant.ApiUrlImage+"\(news_.base64Image)"
        cell.imageNews.kf.setImage(with: URL(string: imageUrl))
        cell.titleNews.text = news_.title
        cell.dateNews.text = news_.createdDate
        return cell
            
        }
        else
        {
            let cell = Bundle.main.loadNibNamed("NewsHeaderTableViewCell", owner: self, options: nil)?.first as! NewsHeaderTableViewCell
            
            let news_ = newsArray[indexPath.row]
            print(news_.title as Any)
            let imageUrl = Constant.ApiUrlImage+"\(news_.base64Image)"
            cell.imageNews.kf.setImage(with: URL(string: imageUrl))
            cell.titleNews.text = news_.title
            cell.dateNews.text = news_.createdDate
            cell.totalViews.text = "\(news_.views!) dilihat"
            return cell
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsData = newsArray[indexPath.item]
        
        showDetailNewsController(with: newsData.id ?? 0,with: newsData.title ?? "", with: newsData.createdDate ?? "", with: newsData.base64Image, with: newsData.description,with:newsData.keyword,with:newsData.category?.categoryName ?? "")
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(self.category == "tips"){
            
            return 100
            
        }else {
            
            return 250
        }
        
    }

}



// MARK: - UIViewController
extension UIViewController {
    
    func showNewsByCategoryController(with categoryName: String) {
        
        let storyboard = UIStoryboard(name: "News", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newsTips") as! TipsViewController
        vc.category = categoryName
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
