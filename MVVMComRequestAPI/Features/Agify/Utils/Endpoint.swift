//
//  Endpoint.swift
//  MVVMComRequestAPI
//
//  Created by Lucas Nascimento on 05/07/22.
//

import Foundation

enum Endpoint {
    case predicting(name: String)
    
    var url: URL {
        switch self {
        case .predicting(let name):
            return URL(string: "\(Environment.basePath)?name=\(name)")!
        }
    }
    
}
