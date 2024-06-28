//
//  SplashVC.swift
//  ImageFeed
//
//  Created by Artem on 26.06.2024.
//

import UIKit

final class SplashVC: UIViewController {
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupUI()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "splash_screen_logo")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 75),
            imageView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
    }
}
