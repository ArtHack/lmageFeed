//
//  AuthVC.swift
//  ImageFeed
//
//  Created by Artem on 17.04.2024.
//

import UIKit

class AuthVC: UIViewController {
    
    private let authImageView = UIImageView()
    private let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(authImageView)
        self.view.addSubview(loginButton)
        
        configureUI()
        setupConstraints()
    }
    
    func configureUI() {
        authImageView.image = UIImage(named: "auth_screen_logo")
        
        loginButton.setTitle("Enter", for: .normal)
        loginButton.setTitleColor(.ifBlack, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = 16
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            authImageView.widthAnchor.constraint(equalToConstant: 60),
            authImageView.heightAnchor.constraint(equalToConstant: 60),
            
            loginButton.centerXAnchor.constraint(equalTo: authImageView.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        authImageView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
    }
}
