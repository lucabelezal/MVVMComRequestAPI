import UIKit

final class AgifyViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    private lazy var viewModel: AgifyViewModel = {
        let viewModel = AgifyViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }

    @IBAction func search(_ sender: Any) {
        viewModel.search(name: textField.text)
    }
    
    private func setupButton() {
        searchButton.layer.cornerRadius = searchButton.bounds.height / 2
        searchButton.dropShadow()
        textField.dropShadow()
    }
    
}

extension AgifyViewController: AgifyViewModelDelegate {
    
    func showEmptyFieldError() {
        showAlert(
            title: "Campo vazio",
            message: "Por favor digite um termo para ser pesquisado"
        )
    }
    
    func showError(message: String?) {
        showAlert(title: "Ops! Não foi possível fazer a busca", message: message)
    }
    
    func showPredicting(of person: PersonModel) {
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
