//
//  FullNewsView.swift
//  RSSNews
//
//  Created by Александр Дергилёв on 11/10/2019.
//  Copyright © 2019 Александр Дергилёв. All rights reserved.
//

import UIKit

class FullNewsView: UIView {
    var newsInfo: News? {
        didSet {
            titleLabel.text = newsInfo?.title
            fullInfoLabel.text = newsInfo?.fullText
            if let url = newsInfo?.imageURL {
                loadImage(url: url)
            } else {
                configure()
            }
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = .systemFont(ofSize: 16)
        lb.numberOfLines = 0
        return lb
    }()
       
    private let fullInfoLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = .systemFont(ofSize: 14)
        lb.numberOfLines = 0
        return lb
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    func configure() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor, constant: 0).isActive = true
        scrollView.heightAnchor.constraint(equalTo: heightAnchor, constant: 0).isActive = true
        
        var flag = false
        if (newsInfo?.imageURL != nil) {
            scrollView.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
            imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: 0).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: self.frame.height / 3).isActive = true
            flag = true
        }
        
        scrollView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        if (flag) {
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        } else {
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        }
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(fullInfoLabel)
        fullInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        fullInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        fullInfoLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: 0).isActive = true
        fullInfoLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func loadImage(url: URL) {
        DispatchQueue.global().async {
           let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
                self.configure()
            }
        }
    }
}
