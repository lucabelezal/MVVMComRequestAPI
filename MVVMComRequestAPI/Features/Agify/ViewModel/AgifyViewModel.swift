//
//  AgifyViewModel.swift
//  MVVMComRequestAPI
//
//  Created by Lucas Nascimento on 05/07/22.
//

import Foundation

protocol AgifyViewModelDelegate: AnyObject {
    func showPredicting(of person: PersonModel)
    func showEmptyFieldError()
    func showError(message: String?)
}

final class AgifyViewModel {
    weak var delegate: AgifyViewModelDelegate?
    
    private let service: AgifyServiceProtocol
    
    init(service: AgifyServiceProtocol = AgifyService()) {
        self.service = service
    }
    
    func search(name: String?) {
        guard let name = name, !name.isEmpty else {
            delegate?.showEmptyFieldError()
            return
        }
        
        service.getSearchPredicting(name: name) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                guard let data = data else {
                    self.delegate?.showError(message: "Nenhum dado encontrado")
                    return
                }
                
                guard let personParsed = try? JSONDecoder().decode(
                    PersonModel.self,
                    from: data
                ) else {
                    self.delegate?.showError(message: "Problema ao fazer o parse")
                    return
                }
                
                self.delegate?.showPredicting(of: personParsed)
                
            case let .failure(error):
                self.delegate?.showError(message: error.localizedDescription)
            }
        }
        
        
//        URLSession.shared.dataTask(
//            with: Endpoint.predicting(name: name).url
//        ) { (data, response, error) in
//
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//
//                if error != nil {
//                    self.delegate?.showError(message: error?.localizedDescription)
//                }
//
//                guard let data = data else {
//                    self.delegate?.showError(message: "Nenhum dado encontrado")
//                    return
//                }
//
//                guard let person = try? JSONDecoder().decode(
//                    PersonModel.self,
//                    from: data
//                ) else {
//                    self.delegate?.showError(message: "Problema ao fazer o parse ")
//                    return
//                }
//
//                self.delegate?.showPredicting(of: person)
//            }
//
//        }
//        .resume()
    }
}
