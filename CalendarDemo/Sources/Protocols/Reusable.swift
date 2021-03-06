import UIKit

protocol Reusable: class {

    static var reuseIdentifier: String { get }

}

extension Reusable {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: Reusable { }

extension UICollectionReusableView: Reusable { }
