//
//  ViewController.swift
//  Contacts
//
//  Created by MyMacBook on 09.07.2022.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    loadContacts()
  }
  
  private var contacts = [ContactProtocol]() {
    didSet {
      contacts.sort { $0.title < $1.title }
    }
  }

  
  private func loadContacts() {
    contacts.append(
      Contact(title: "Sanya Tech inspection", phone: "+799912312323"))
    contacts.append(
      Contact(title: "Volodimir Anatolyevich", phone: "+781213342321"))
    contacts.append(
      Contact(title: "Silvester", phone: "+7001911112"))
  }
  
  @IBAction func showNewContactAlert() {
    // Creation of Alert Controller
    let alertController = UIAlertController(title: "Create a contact", message: "Insert your name and phone number", preferredStyle: .alert)
    // Add the first text field into Alert Controller
    alertController.addTextField { textField in
      textField.placeholder = "Name"
    }
    // Add the second text field into Alert Controller
    alertController.addTextField { textField in
      textField.placeholder = "Phone number"
    }
    // button for creating contacts
    let createButton = UIAlertAction(title: "Create", style: .default) { _ in
      guard let contactName = alertController.textFields?[0].text,
            let phoneNumber = alertController.textFields?[1].text else { return
            }
      // Create a new contact
      let contact = Contact(title: contactName, phone: phoneNumber)
      self.contacts.append(contact)
      self.tableView.reloadData()
    }
    // Cancel button
    let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    // Add buttons to Alert Controller
    alertController.addAction(createButton)
    alertController.addAction(cancelButton)
    // Render Alert Controller
    present(alertController, animated: true, completion: nil)
  }

}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell: UITableViewCell
    if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
      print("Use an old cell for an index row \(indexPath.row)")
      cell = reuseCell
    } else {
      print("Create a new cell for an index row \(indexPath.row)")
      cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
    }
    
    configure(cell: &cell, for: indexPath)
    return cell
  }
  
  private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
    var configuration = cell.defaultContentConfiguration()
    // Contact name
    configuration.text = contacts[indexPath.row].title
    // Phone number
    configuration.secondaryText = contacts[indexPath.row].phone
    cell.contentConfiguration = configuration
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    // delete action
    let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
      // delete a contact
      self.contacts.remove(at: indexPath.row)
      // update the table view
      tableView.reloadData()
    }
    // form an instance which describes available actions
    let actions = UISwipeActionsConfiguration(actions: [actionDelete])
    return actions
  }
}
