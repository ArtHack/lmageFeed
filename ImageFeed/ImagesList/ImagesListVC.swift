//
//  ViewController.swift
//  ImageFeed
//
//  Created by Artem on 02.03.2024.
//

import UIKit

class ImagesListVC: UIViewController {
    
    private let photosName: [String] = Array(0..<20).map { "\($0)" }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(ImagesListCell.self, forCellReuseIdentifier: ImagesListCell.reuseIdentifier)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.rowHeight = 200
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
    }
    
    func configureCell(for cell: ImagesListCell) {
        
    }
}

// MARK: - UITableViewDataSource
extension ImagesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        guard let imagesListCell = cell as? ImagesListCell else {
            NSLog("Failed to dequeue a cell with identifier: \(ImagesListCell.reuseIdentifier)")
            return UITableViewCell()
        }
        configureCell(for: imagesListCell)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ImagesListVC: UITableViewDelegate {
    
}
