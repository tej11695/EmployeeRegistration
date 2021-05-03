//
//  Extension.swift
//  Tej's Practical
//
//  Created by PCS29 on 11/04/21.
//

import Foundation

extension String
{
    var isValidEmail: Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool
    {
        let phoneRegEx = "^[6-9]\\d{9}$"
        //let phoneRegEx = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
    
}

extension String {
    func containsOnlyLettersAndWhitespace() -> Bool {
        let allowed = CharacterSet.letters.union(.whitespaces)
        return unicodeScalars.allSatisfy(allowed.contains)
    }
}

extension Array where Element: Equatable {
  
  mutating func removeEqualItems(_ item: Element) {
    self = self.filter { (currentItem: Element) -> Bool in
      return currentItem != item
    }
  }

  mutating func removeFirstEqualItem(_ item: Element) {
    guard var currentItem = self.first else { return }
    var index = 0
    while currentItem != item {
      index += 1
      currentItem = self[index]
    }
    self.remove(at: index)
  }
  
}

