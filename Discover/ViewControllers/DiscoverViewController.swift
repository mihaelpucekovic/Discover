//
//  DiscoverViewController.swift
//  Discover
//
//  Created by Mihael Puceković on 27/09/2020.
//

import UIKit
import CoreData

class DiscoverViewController: UIViewController, NewsPressedDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewDiscover: UIView!
    var newsDB = [News]()
    var newsViews = [NewsView]()
    var selectedNews: News?
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        fetchNewsFromDatabase()
        fetchNewsFromAPI()
    }
    
    func setupNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setGradientBackgroundNavBar(colors: [UIColor.systemYellow.cgColor,UIColor.systemOrange.cgColor])
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.viewDiscover.setGradientBackgroundView(colors: [UIColor.systemYellow.cgColor,UIColor.systemOrange.cgColor])
    }
    
    func fetchNewsFromDatabase() {
        self.newsDB = Database().fetchNewsFromDatabase(context: context)
        
        newsViews = createNewsViews()
        setupScrollView()
    }
    
    func fetchNewsFromAPI() {
        NewsService().fetchNews() { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let news as [News]):
                    self?.saveAndUpdateNews(newsAPI: news)
                case .failure( _):
                    let alert = UIAlertController(title: "Error", message: "Error while feetching news from the API.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                        self!.fetchNewsFromAPI()
                    }))
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
                    self!.present(alert, animated: true, completion: nil)
                case .none:
                    break
                case .some(.success(_)):
                    break
                }
            }
        }
    }
    
    func saveAndUpdateNews(newsAPI: [News]) {
        Database().saveAndUpdateNews(newsAPI: newsAPI, newsDB: newsDB, context: context)
        
        fetchNewsFromDatabase()
    }
    
    func createNewsViews() -> [NewsView] {
        var views: [NewsView] = []
        
        for news in newsDB {
            let view:NewsView = Bundle.main.loadNibNamed("NewsView", owner: self, options: nil)?.first as! NewsView
            view.titleNews.text = news.title
            view.captionNews.text = news.caption
            view.imageNews.image = UIImage(data: news.imageData)
            view.publishedNews.text = "published: \(timestampToString(timestamp: Double(news.createdAt)))"
            view.imageNews.layer.cornerRadius = 10;
            view.imageNews.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            view.viewInfo.layer.cornerRadius = 10;
            view.viewInfo.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            view.news = news
            
            view.delegate = self
            
            views.append(view)
        }
        
        return views
    }
    
    func timestampToString(timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    func setupScrollView() {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(newsViews.count), height: view.frame.height)
        scrollView.contentSize.height = 1.0
        
        for i in 0 ..< newsViews.count {
            newsViews[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(newsViews[i])
        }
    }
    
    func newsPressed(news: News) {
        selectedNews = news

        performSegue(withIdentifier: "segueNews", sender: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueNews" {
            let newsViewController = segue.destination as! NewsViewController
            
            newsViewController.news = selectedNews
        }
    }
}
