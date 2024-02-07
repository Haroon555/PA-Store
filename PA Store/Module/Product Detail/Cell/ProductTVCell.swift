//
//  ProductTVCell.swift
//  PA Store
//
//  Created by Haroon Shoukat on 22/09/2023.
//

import UIKit

class ProductTVCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> ProductTVCell {
        let cellIdentifier = "ProductTVCell"
        tableView.register(UINib(nibName: "ProductTVCell", bundle: nil), forCellReuseIdentifier: "ProductTVCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductTVCell
        return cell
    }
    
}
