//
//  AkbumTableViewCell.swift
//  Assiignment_1_Albums
//
//  Created by Deepali on 23/03/24.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
