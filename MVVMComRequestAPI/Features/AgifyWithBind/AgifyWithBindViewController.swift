import UIKit

final class AgifyWithBindViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    private lazy var viewModel: AgifyWithBindViewModelProtocol = {
        let viewModel = AgifyWithBindViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupBindings()
    }
    
    @IBAction func search(_ sender: Any) {
        viewModel.search(name: textField.text)
    }
    
    private func setupButton() {
        searchButton.layer.cornerRadius = searchButton.bounds.height / 2
        searchButton.dropShadow()
        textField.dropShadow()
    }
    
    private func setupBindings() {
        viewModel.personData.bind { [weak self] person in
            self?.showPredicting(of: person)
        }
        
        viewModel.errorMessage.bind { [weak self] message in
            self?.showError(message: message)
        }
        
        viewModel.emptyFieldError.bind { [weak self] _ in
            self?.showEmptyFieldError()
        }
    }
    
    private func showEmptyFieldError() {
        showAlert(
            title: "Campo vazio",
            message: "Por favor digite um termo para ser pesquisado"
        )
    }
    
    private func showError(message: String?) {
        showAlert(title: "Ops! Não foi possível fazer a busca", message: message)
    }
    
    private func showPredicting(of person: PersonModel?) {
        guard let person = person else { return }
        showAlert(
            title: "Resultado",
            message: """
            Nome: \(person.name)
            Idade: \(person.age)
            Quantidade: \(person.count)
            """
        )
    }
}
