//
//  NewsView.swift
//  Discover
//
//  Created by Mihael Puceković on 25/09/2020.
//

import UIKit

protocol NewsPressedDelegate: AnyObject {
    func newsPressed(news: News)
}

class NewsView: UITableViewCell {
 
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var captionNews: UILabel!
    @IBOutlet weak var publishedNews: UILabel!
    @IBOutlet weak var viewInfo: UIView!
    
    weak var delegate:NewsPressedDelegate?
    var news:News?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.selectedAction))
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector(self.selectedAction))
        self.imageNews.addGestureRecognizer(gesture)
        self.viewInfo.addGestureRecognizer(gesture2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageNews = nil
        titleNews.text = ""
        captionNews.text = ""
        publishedNews.text = ""
    }

    func timestampToString(timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    @objc func selectedAction(sender : UITapGestureRecognizer) {
        delegate?.newsPressed(news: news!)
    }
}
