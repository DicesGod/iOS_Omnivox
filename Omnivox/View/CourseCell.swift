//
//  CourseCell.swift
//  Omnivox
//
//  Created by english on 2019-07-22.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {
    
    @IBOutlet weak var courseIDLbl: UILabel!
    @IBOutlet weak var courseTitleLbl: UILabel!
    @IBOutlet weak var creditsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
