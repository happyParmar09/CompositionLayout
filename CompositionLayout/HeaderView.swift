//
//  HeaderView.swift
//  CompositionLayout
//
//  Created by gokulparmar on 25/09/22.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var title : String? {
        didSet{
            titleLabel.text = title 
        }
    }
}
