//
//  AgifyService.swift
//  MVVMComRequestAPI
//
//  Created by Lucas Nascimento on 05/07/22.
//

import Foundation

protocol AgifyServiceProtocol: AnyObject {
    func getSearchPredicting(name: String, completion: @escaping (Result<Data?, Error>) -> Void)
}

final class AgifyService: AgifyServiceProtocol {

    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getSearchPredicting(
        name: String,
        completion: @escaping (Result<Data?, Error>) -> Void
    ) {
        session.dataTask(with: Endpoint.predicting(name: name).url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                completion(.success(data))
            }
        }
        .resume()
    }
    
}

// https://api.agify.io?name=michael

//{
//   "name":"michael",
//   "age":70,
//   "count":233482
//}
