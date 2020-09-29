//
//  NewsViewController.swift
//  Discover
//
//  Created by Mihael Puceković on 28/09/2020.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var descriptionNews: UILabel!
    @IBOutlet weak var publishedNews: UILabel!
    
    var news: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageNews.image = UIImage(data: news!.imageData)
        titleNews.text = news?.title
        descriptionNews.text = news?.description
        publishedNews.text = "Published: \(timestampToString(timestamp: Double(news!.createdAt)))"
    }

    @IBAction func sharedLinkPressed(_ sender: UIButton) {
        let objectsToShare = [news?.shareLink]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare as [Any], applicationActivities: nil)

        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popup = activityViewController.popoverPresentationController {
                popup.sourceView = self.view
                popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
            }
        }

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func timestampToString(timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
