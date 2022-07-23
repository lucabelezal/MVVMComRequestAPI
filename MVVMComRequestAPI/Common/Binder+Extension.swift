import UIKit

// MARK: - UIButton

extension UIButton {
    func bindTo(_ bindable: Binder<Bool>) {
        bindable.bind { [weak self] isEnabled in
            self?.isEnabled = isEnabled
        }
    }
}

// MARK: - UITextField

extension UITextField {
    func bindTo(_ bindable: Binder<String>) {
        bindable.bind { [weak self] text in
            self?.text = text
        }
    }
}

// MARK: - UILabel

extension UILabel {
    func bindTo(_ bindable: Binder<String>) {
        bindable.bind { [weak self] text in
            self?.text = text
        }
    }
    
    func bindTo(_ bindable: Binder<NSAttributedString>) {
        bindable.bind { [weak self] attributedText in
            self?.attributedText = attributedText
        }
    }
}

// MARK: - UITableView

extension UITableView {
    func bindTo<T>(_ bindable: Binder<T>) {
        bindable.bind { [weak self] _ in
            self?.reloadData()
        }
    }
}

// MARK: - UISwitch

extension UISwitch {
    func bindTo(_ bindable: Binder<Bool>) {
        bindable.bind { [weak self] isOn in
            self?.setOn(isOn, animated: true)
        }
    }
}

// MARK: - UIActivityIndicatorView

extension UIActivityIndicatorView {
    func bindTo(_ bindable: Binder<Bool>) {
        bindable.bind { [weak self] isEnabled in
            if isEnabled {
                self?.isHidden = false
                self?.startAnimating()
            } else {
                self?.isHidden = true
                self?.stopAnimating()
            }
        }
    }
}
