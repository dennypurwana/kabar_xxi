//
//  NewsDetailViewController.swift
//  KabarXXI_
//
//  Created by Emerio-Mac2 on 20/04/19.
//  Copyright © 2019 Emerio-Mac2. All rights reserved.
//

import UIKit
import Floaty


class NewsDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate   {
    
    
    let floaty = Floaty()
    
    var newsArray: [News] = []
    var keyword: String?
    var titleNews_: String?
    var newsDescriptions_: String?
    var imageNews_ : String = ""
    var createdDate_ : String = ""
    var category_ : String = ""
    var idNews_:Int = 0
    var releaseDate: Date = Date(timeIntervalSince1970: 0)
    
    
    @IBOutlet var commentButton: UITableView!
    
    @IBOutlet var relatedNewsTableView: UITableView!
    
    @IBOutlet var imageNews: UIImageView!
    
    @IBOutlet var titleNews: UILabel!
    
    @IBOutlet var createdDate: UILabel!
    
    @IBOutlet var descNews: UILabel!
    
    @IBOutlet var category: UILabel!
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        
        self.showCommentViewController(with: idNews_)
        
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViews()
       
        
    }
    
    
    func setupViews(){
        
        self.navigationItem.title = "Detail Berita"
        titleNews.text = titleNews_
        descNews.htmlToString(html: newsDescriptions_ ?? "")
        createdDate.text = createdDate_
        category.text = category_
        let imageUrl = Constant.ApiUrlImage+"\(imageNews_)"
        imageNews.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "default_image"))
        updateViews(idNews_)
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
        //loadNews(keyword ?? "")
    }
    
    
    func updateViews(_ id: Int) {
        print(id)
        newsProviderServices.request(.updateViews(id)) { [weak self] result in
            guard case self = self else { return }
            switch result {
            case .success(let response):
                
                    print(response)
            
            case .failure: break
            }
        
        }
        
    }
    
    func loadNews(_ keyword: String) {
        print(keyword)
        newsProviderServices.request(.getRelatedNews(keyword: keyword)) { [weak self] result in
            guard case self = self else { return }
            
            // 3
            switch result {
            case .success(let response):
                do {
                    
                    let decoder = JSONDecoder()
                    let responses = try decoder.decode(NewsResponse.self, from:
                        response.data)
                    print(responses)
                    self?.newsArray = responses.data ?? []
                    self?.relatedNewsTableView.reloadData()
                    
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
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsData = newsArray[indexPath.item]
        
        showDetailNewsController(with: newsData.id ?? 0,with: newsData.title ?? "", with: newsData.createdDate ?? "", with: newsData.base64Image!, with: newsData.description ?? "",with: newsData.keyword ?? "",with:newsData.category?.categoryName ?? "")
        
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
            return 100
    
    }
    
    
    
}



// MARK: - UIViewController
extension UIViewController {
    
    func showDetailNewsController(with idNews: Int,with title: String, with createdDate: String, with imageNews: String, with description: String,with keyword: String,with categoryName: String) {
        
        let storyboard = UIStoryboard(name: "News", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newsDetail") as! NewsDetailViewController
        vc.idNews_ = idNews
        vc.newsDescriptions_ = description
        vc.imageNews_ = imageNews
        vc.titleNews_ = title
        vc.createdDate_ = createdDate
        vc.keyword = keyword
        vc.category_ = categoryName
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

