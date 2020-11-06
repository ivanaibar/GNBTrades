//
//  ProductTransactionsTableViewCell.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 05/11/2020.
//

import UIKit

class ProductTransactionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var amountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(with transaction: Transaction) {
        amountLabel.text = transaction.amount + " " + transaction.currency
    }
    
}
