//
//  ViewController.swift
//  RSSNews
//
//  Created by Александр Дергилёв on 11/10/2019.
//  Copyright © 2019 Александр Дергилёв. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RSSParserProtocol, FilterVCProtocol {
    let url = URL(string: "https://www.vesti.ru/vesti.rss")!
    let cellId = "NewsCell"
    var newsArray: [News] = []
    var filteredNewsItems: [Int] = []
    var allCategories = Set<String>()
    var selectedCategories: [String] = []
    
    var tableView: UITableView = UITableView()
    var rssParser = RSSParser()
    let childVC = FilterVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        rssParser.delegate = self
        rssParser.startParsingWithContentsOfURL(rssURL: url)
        childVC.delegate = self
        configureNavigationBar()

        view.addSubview(tableView)
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Идет обновление...")
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        updateLayout(with: self.view.bounds.size)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: cellId)
    }

    private func configureNavigationBar() {
        self.title = "Список новостей"
        let filterBtn = UIBarButtonItem(title: "Фильтр", style: .done, target: self, action: #selector(clickOnFilterBtn))
        self.navigationItem.setRightBarButton(filterBtn, animated: false)
    }

    @objc
    func refresh() {
        rssParser.startParsingWithContentsOfURL(rssURL: url)
        self.tableView.refreshControl?.endRefreshing()
    }
    @objc
    func clickOnFilterBtn() {
        childVC.allCategories = Array(allCategories)
        childVC.selectedCategories = selectedCategories
        navigationController?.pushViewController(childVC, animated: false)
    }
    // MARK - UITableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewsCell
        let currentNews: News
        if selectedCategories.isEmpty {
            currentNews = newsArray[indexPath.row]
        } else {
            currentNews = newsArray[filteredNewsItems[indexPath.row]]
        }
        cell.news = currentNews
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCategories.isEmpty {
            return newsArray.count
        }
        return filteredNewsItems.count
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FullNewsVC()
        if selectedCategories.isEmpty {
            vc.currentNews = newsArray[indexPath.row]
        } else {
            vc.currentNews = newsArray[filteredNewsItems[indexPath.row]]
        }
        navigationController?.pushViewController(vc, animated: false)
    }
    
    //MARK - Private
    private func updateLayout(with size: CGSize) {
        self.tableView.frame = CGRect.init(origin: .zero, size: size)
    }
    
    // MARK - Delegate
    func parsingWasFinish() {
        newsArray = rssParser.newsArray
        for currentnews in newsArray {
            allCategories.insert(currentnews.category)
        }
        self.tableView.reloadData()
    }
    
    func saveFilters(selectedCategories: [String]) {
        filteredNewsItems = []
        self.selectedCategories = selectedCategories
        for (index, news) in newsArray.enumerated() {
            if selectedCategories.contains(news.category) {
                filteredNewsItems.append(index)
            }
        }
        self.tableView.reloadData()
    }
}

