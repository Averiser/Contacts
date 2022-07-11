//
//  Contact.swift
//  Contacts
//
//  Created by MyMacBook on 09.07.2022.
//

import Foundation

protocol ContactProtocol {
  // Name
  var title: String {get set}
  // Phone number
  var phone: String {get set}
}

struct Contact: ContactProtocol {
  var title: String
  
  var phone: String
  
  
}


