//
//  FullNewsVC.swift
//  RSSNews
//
//  Created by Александр Дергилёв on 11/10/2019.
//  Copyright © 2019 Александр Дергилёв. All rights reserved.
//

import UIKit

class FullNewsVC: UIViewController {
    var currentNews: News?
    let fullNewsView = FullNewsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let news = currentNews else {
            return
        }
        fullNewsView.newsInfo = news
    }

    private func configure() {
        let height = navigationController?.navigationBar.frame.maxY ?? 0
        view.addSubview(fullNewsView)
        fullNewsView.translatesAutoresizingMaskIntoConstraints = false
        fullNewsView.topAnchor.constraint(equalTo: view.topAnchor, constant: height).isActive = true
        fullNewsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        fullNewsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        fullNewsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}
