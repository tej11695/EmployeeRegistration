//
//  EmpListCell.swift
//  Tej's Practical
//
//  Created by PCS29 on 11/04/21.
//

import UIKit
import CoreData

class EmpListCell: UITableViewCell {
    
    @IBOutlet weak var lblEmpName: UILabel!
    @IBOutlet weak var lblEmpDesignation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setData(dictData: NSManagedObject){
        self.lblEmpName.text = dictData.value(forKey: "name") as? String ?? ""
        self.lblEmpDesignation.text = dictData.value(forKey: "designation") as? String ?? ""

    }
    
}
