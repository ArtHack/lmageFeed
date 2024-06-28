//
//  URLRequest+Extension.swift
//  ImageFeed
//
//  Created by Artem on 06.06.2024.
//

import Foundation

extension URLRequest {
    enum NetworkError: Error {
        case httpStatusCode(Int)
        case urlRequestError(Error)
        case urlSessionError
    }
    
    func sessionTask(for request: URLRequest,
                     completion: @escaping (Result<Data, Error>) -> Void) ->
    URLSessionDataTask? {
        let fulfillCompletion: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let data = data,
               let response = response,
               let statusCode = (response as? HTTPURLResponse)?.statusCode
            {
                if 200 ..< 300 ~= statusCode {
                    fulfillCompletion(.success(data))
                } else {
                    fulfillCompletion(.failure(NetworkError.httpStatusCode(statusCode)))
                }
            } else if let error = error {
                fulfillCompletion(.failure(NetworkError.urlRequestError(error)))
            } else {
                fulfillCompletion(.failure(NetworkError.urlSessionError))
            }
        })
        return task
    }
    
    static func makeHTTPRequest(
        path: String,
        httpMethod: String,
        baseURL: URL = Constants.defaultBaseURL!
    ) -> URLRequest {
        var request = URLRequest(url: URL(string: path, relativeTo: baseURL)!)
        request.httpMethod = httpMethod
        return request
    }
}
