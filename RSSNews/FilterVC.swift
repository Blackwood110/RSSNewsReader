//
//  FilterVC.swift
//  RSSNews
//
//  Created by Александр Дергилёв on 13/10/2019.
//  Copyright © 2019 Александр Дергилёв. All rights reserved.
//

import UIKit
protocol FilterVCProtocol: class {
    func saveFilters(selectedCategories: [String])
}

class FilterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let cellId = "CategoryCell"
    var allCategories: [String] = []
    var selectedCategories: [String] = []
    var tableView: UITableView = UITableView()
    var delegate: FilterVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        view.addSubview(tableView)
        updateLayout(with: self.view.bounds.size)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func configureNavigationBar() {
        self.title = "Категории"
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(clickOnSaveBtn))
        self.navigationItem.setRightBarButton(saveBtn, animated: false)
    }
    
    @objc
    func clickOnSaveBtn() {
        delegate?.saveFilters(selectedCategories: selectedCategories)
        self.navigationController?.popViewController(animated: false)
    }
    // MARK - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let currentCategory = allCategories[indexPath.row]
        if selectedCategories.contains(currentCategory) {
            cell.accessoryType = .checkmark
        }
        cell.textLabel?.text = currentCategory
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            for (index, category) in selectedCategories.enumerated() {
                if category == allCategories[indexPath.row] {
                    selectedCategories.remove(at: index)
                    return
                }
            }
        } else {
            cell.accessoryType = .checkmark
            selectedCategories.append(allCategories[indexPath.row])
        }
    }
    
    //MARK - Private
    private func updateLayout(with size: CGSize) {
        self.tableView.frame = CGRect.init(origin: .zero, size: size)
    }
}
