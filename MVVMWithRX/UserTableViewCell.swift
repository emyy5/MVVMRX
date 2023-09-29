//
//  UserTableViewCell.swift
//  MVVMWithRX
//
//  Created by Eman Khaled on 29/09/2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
