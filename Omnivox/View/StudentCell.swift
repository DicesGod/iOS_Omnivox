//
//  StudentCell.swift
//  Omnivox
//
//  Created by english on 2019-07-22.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {
    
    @IBOutlet weak var studentIDLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
