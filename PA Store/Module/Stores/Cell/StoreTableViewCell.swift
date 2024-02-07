//
//  StoreTableViewCell.swift
//  PA Store
//
//  Created by Haroon Shoukat on 10/10/2023.
//

import UIKit

class StoreTableViewCell: UITableViewCell {
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrimaryStore: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
