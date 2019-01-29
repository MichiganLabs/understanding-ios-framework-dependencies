import UIKit
import Models
import Common
import UI
import Reusable

class ViewController: UIViewController {

    @IBOutlet private var firstNameTextField: UITextField!
    @IBOutlet private var lastNameTextField: UITextField!
    @IBOutlet private var submitButton: CustomButton!
    @IBOutlet private var tableView: UITableView!

    private var customers = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateState(first: self.firstNameTextField.text, last: self.lastNameTextField.text)

        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(cellType: PersonCell.self)
    }

    @IBAction func didPressSubmit(_ sender: Any) {
        guard
            let first = self.firstNameTextField.text,
            let last = self.lastNameTextField.text
        else {
            return
        }

        self.customers.append(Person(first: first, last: last))
        self.tableView.reloadData()

        self.firstNameTextField.text = nil
        self.lastNameTextField.text = nil

        self.view.endEditing(true)

        self.updateState(first: nil, last: nil)
    }

    private func updateState(first: String?, last: String?) {
        let isValid = (first?.isNotEmpty ?? false) && (last?.isNotEmpty ?? false)
        self.submitButton.isEnabled = isValid
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        var first = self.firstNameTextField.text
        var last = self.lastNameTextField.text

        switch textField {
        case self.firstNameTextField:
            first = string
        case self.lastNameTextField:
            last = string
        default:
            break
        }

        self.updateState(first: first, last: last)

        return true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as PersonCell
        let person = self.customers[indexPath.row]
        cell.setup(person: person)

        return cell
    }
}

