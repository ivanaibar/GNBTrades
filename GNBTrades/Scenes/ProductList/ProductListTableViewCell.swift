//
//  ProductListTableViewCell.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 04/11/2020.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var productLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(with product: Transaction) {
        productLabel.text = product.sku
    }
}
