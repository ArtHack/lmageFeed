//
//  WebViewVC.swift
//  ImageFeed
//
//  Created by Artem on 17.04.2024.
//

import WebKit
import UIKit

private struct APIConstants {
    static let authorizeURLString = "https://unsplash.com/oauth/authorize"
    static let code = "code"
    static let authorizationPath = "/oauth/authorize/native"
}

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewVC, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewVC)
}

class WebViewVC: UIViewController {
    
    let webView = WKWebView()
    let backButton = UIButton()
    let progressView = UIProgressView()
    
    weak var delegate: WebViewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        webView.navigationDelegate = self

        loadWebView()
        updateProgress()
        
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        webView.removeObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            context: nil)
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?) {
            if keyPath == #keyPath(WKWebView.estimatedProgress) {
                updateProgress()
            } else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            }
    }
    
    private func updateProgress() {
        progressView.progress = Float(webView.estimatedProgress)
        progressView.isHidden = fabs(webView.estimatedProgress - 1.0) <= 0.0001
    }
    
    func setupUI() {
        view.addSubview(webView)
        view.addSubview(backButton)
        view.addSubview(progressView)
                
        backButton.setImage(UIImage(named: "nav_back_button"), for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        progressView.progressViewStyle = .default
        progressView.tintColor = .ifBlack
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            progressView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 8),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        webView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc
    private func didTapBackButton() {
        dismiss(animated: true)
    }
}

private extension WebViewVC {
    func loadWebView() {
        var components = URLComponents(string: APIConstants.authorizeURLString)
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "response_type", value: APIConstants.code),
            URLQueryItem(name: "scope", value: Constants.accessScope)
        ]
        if let url = components?.url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

extension WebViewVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let code = fetchCode(from: navigationAction.request.url) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func fetchCode(from url: URL?) -> String? {
        if let url = url,
           let components = URLComponents(string: url.absoluteString),
           components.path == APIConstants.authorizationPath,
           let codeItem = components.queryItems?.first(where: { $0.name == APIConstants.code }) {
            return codeItem.value
        } else {
            return nil
        }
    }
}

