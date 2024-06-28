//
//  AuthVC.swift
//  ImageFeed
//
//  Created by Artem on 17.04.2024.
//

import UIKit

protocol AuthVCDelegate: AnyObject {
    func authViewController(_ vc: AuthVC, didAuthenticateWithCode code: String)
}

final class AuthVC: UIViewController {
    
    weak var delegate: AuthVCDelegate?

// MARK: - UI
    private let authImageView = UIImageView()
    private let loginButton = UIButton()
    
    let webView = WebViewVC()

// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        view.backgroundColor = .ifBlack
        
        self.view.addSubview(authImageView)
        self.view.addSubview(loginButton)
        
        setupUI()
        setupConstraints()
    }

// MARK: - UISetup Methods
    func setupUI() {
        authImageView.image = UIImage(named: "auth_screen_logo")
        
        loginButton.setTitle("Enter", for: .normal)
        loginButton.setTitleColor(.ifBlack, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = 16
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
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
    
    @objc
    func didTapLoginButton() {
        let VC = WebViewVC()
        present(VC, animated: false)
    }
}

// MARK: - WebViewViewControllerDelegate
extension AuthVC: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewVC, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewVC) {
        dismiss(animated: true)
    }
}
