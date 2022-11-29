//
//  ChatTVC.swift
//  Firebase_Tinder
//
//  Created by Ripon sk on 20/11/22.
//

import UIKit

class ChatTVC: UITableViewCell {
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var profile: UIImageView!
    
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
