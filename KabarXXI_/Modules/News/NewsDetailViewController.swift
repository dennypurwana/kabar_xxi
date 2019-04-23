//
//  NewsDetailViewController.swift
//  KabarXXI_
//
//  Created by Emerio-Mac2 on 20/04/19.
//  Copyright © 2019 Emerio-Mac2. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate   {
    
    
    @IBOutlet var relatedNewsTableView: UITableView!
    
    @IBOutlet var imageNews: UIImageView!
    
    @IBOutlet var titleNews: UILabel!
    
    @IBOutlet var createdDate: UILabel!
    
    @IBOutlet var descNews: UILabel!
    
     var newsArray: [News] = []
    var keyword: String?
    var titleNews_: String?
    var newsDescriptions_: String?
    var imageNews_ : String = ""
    var createdDate_ : String = ""
    var releaseDate: Date = Date(timeIntervalSince1970: 0)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
         self.navigationItem.title = "Detail Berita"
        titleNews.text = titleNews_
        descNews.htmlToString(html: newsDescriptions_ ?? "")
        releaseDate = createdDate_.date(with: "yyyy-MM-dd")
        createdDate.text = releaseDate.string(with: "yyyy-MM-dd")
        let imageUrl = Constant.ApiUrlImage+"\(imageNews_)"
        print(imageUrl)
        imageNews.kf.setImage(with: URL(string: imageUrl))
        loadNews(keyword ?? "")
        
    }
    
    override func backButtonTapped(_ sender: Any) {
        
        if navigationController?.viewControllers.first == self {
            dismiss(animated: true, completion: nil)
        }
        else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        loadNews(keyword ?? "")
    }
    
    func loadNews(_ keyword: String) {
        print(keyword)
        newsProviderServices.request(.getRelatedNews(keyword: keyword)) { [weak self] result in
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
                    print(responses)
                    self?.newsArray = responses.data
                    self?.relatedNewsTableView.reloadData()
                    print("refreshhh")
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            case .failure: break
            }
            
            //self?.refreshControl_?.endRefreshing()
            self?.relatedNewsTableView.finishInfiniteScroll()
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        self.relatedNewsTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
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



// MARK: - UIViewController
extension UIViewController {
    
    func showDetailNewsController(with title: String, with createdDate: String, with imageNews: String, with description: String,with keyword: String) {
        
        let storyboard = UIStoryboard(name: "News", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newsDetail") as! NewsDetailViewController
        vc.newsDescriptions_ = description
        vc.imageNews_ = imageNews
        vc.titleNews_ = title
        vc.createdDate_ = createdDate
        vc.keyword = keyword
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

