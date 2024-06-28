//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Artem on 25.04.2024.
//

import Foundation

final class OAuth2Service {
    private var task: URLSessionTask?
    private var lastCode: String?
    
    private var authToken: String? {
        get {
            OAuthTokenStorage().token
        }
        set {
            OAuthTokenStorage().token = newValue
        }
    }
    
    func fetchAuthToken(_ code: String, completion: @escaping (Result<String, Error>)-> Void) {
        assert(Thread.isMainThread)
        if lastCode == code { return }
        task?.cancel()
        lastCode = code
        
        guard let request = authTokenRequest(code: code) else { return }
        
        let task = URLSession.shared.objectTask(for: request) { [weak self]
        (result:Result<OAuthTokenResponseBody, Error>) in
            guard let self else { return }
            self.task = nil
            switch result {
            case .success(let body):
                let authToken = body.accessToken
                self.authToken = authToken
                completion(.success(authToken))
            case .failure(let error):
                self.lastCode = nil
                completion(.failure(error))
            }
        }
        self.task = task
        task?.resume()
    }
    
    private func authTokenRequest(code: String) -> URLRequest? {
        guard let url = Constants.defaultBaseURL else { return nil }
        return URLRequest.makeHTTPRequest(
            path: "/oauth/token"
            + "?client_id=\(Constants.accessKey)"
            + "&&client_secret=\(Constants.secretKey)"
            + "&&redirect_uri=\(Constants.redirectURI)"
            + "&&code=\(code)"
            + "&&grant_type=authorization_code",
            httpMethod: "POST",
            baseURL: url
        )
    }
}
