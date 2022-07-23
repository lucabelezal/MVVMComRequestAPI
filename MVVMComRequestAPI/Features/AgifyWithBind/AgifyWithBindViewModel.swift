import Foundation

protocol AgifyWithBindViewModelProtocol: AnyObject {
    var personData: Binder<PersonModel?> { get }
    var errorMessage: Binder<String?> { get }
    var emptyFieldError: Binder<String?> { get }
    func search(name: String?)
}

final class AgifyWithBindViewModel: AgifyWithBindViewModelProtocol {
    
    var personData: Binder<PersonModel?> = Binder(nil)
    var errorMessage: Binder<String?> = Binder(nil)
    var emptyFieldError: Binder<String?> = Binder(nil)
    
    private let service: AgifyServiceProtocol
    
    init(service: AgifyServiceProtocol = AgifyService()) {
        self.service = service
    }
    
    func search(name: String?) {
        guard let name = name, !name.isEmpty else {
            self.emptyFieldError.value = nil
            return
        }

        service.getSearchPredicting(name: name) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                guard let data = data else {
                    self.errorMessage.value = "Nenhum dado encontrado"
                    return
                }
                
                guard let personParsed = try? JSONDecoder().decode(PersonModel.self, from: data) else {
                    self.errorMessage.value = "Problema ao fazer o parse"
                    return
                }
                
                self.personData.value = personParsed
                
            case let .failure(error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
