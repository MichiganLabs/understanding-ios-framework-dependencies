import UIKit
import Models
import Reusable

public class PersonCell: UITableViewCell, NibReusable {

    @IBOutlet private var firstLabel: UILabel!
    @IBOutlet private var lastLabel: UILabel!

    public func setup(person: Person) {
        self.firstLabel.text = person.firstName
        self.lastLabel.text = person.lastName
    }
}
