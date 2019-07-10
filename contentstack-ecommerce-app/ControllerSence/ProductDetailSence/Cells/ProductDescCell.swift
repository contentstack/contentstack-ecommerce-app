//
//  ProductDescCell.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 03/12/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit

class ProductDescCell: UITableViewCell {

    @IBOutlet weak var Productdesc: UILabel!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var relatedProducts: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
