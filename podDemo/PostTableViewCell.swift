//
//  PostTableViewCell.swift
//  podDemo
//
//  Created by Apple on 18/11/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var idLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
