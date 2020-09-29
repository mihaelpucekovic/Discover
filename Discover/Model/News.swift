//
//  News.swift
//  Discover
//
//  Created by Mihael Puceković on 28/09/2020.
//

import Foundation

struct News {
    let id: Int
    let imageURL: String
    let imageData: Data
    let shareLink: String
    let isHighlighted: Bool
    let createdAt: Int
    let updatedAt: Int
    let caption: String
    let isPromoted: Int
    let highlightedText: String
    let highlightedIcon: String
    let highlightedGradientColorFirst: String
    let highlightedGradientColorSecond: String
    let title: String
    let description: String
     
    init(id: Int, imageURL: String, imageData: Data, shareLink: String, isHighlighted: Bool, createdAt: Int, updatedAt: Int, caption: String, isPromoted: Int, highlightedText: String, highlightedIcon: String, highlightedGradientColorFirst: String, highlightedGradientColorSecond: String, title: String, description: String) {
        self.id = id
        self.imageURL = imageURL
        self.imageData = imageData
        self.shareLink = shareLink
        self.isHighlighted = isHighlighted
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.caption = caption
        self.isPromoted = isPromoted
        self.highlightedText = highlightedText
        self.highlightedIcon = highlightedIcon
        self.highlightedGradientColorFirst = highlightedGradientColorFirst
        self.highlightedGradientColorSecond = highlightedGradientColorSecond
        self.title = title
        self.description = description
    }
}
