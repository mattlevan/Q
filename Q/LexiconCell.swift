//
//  LexiconCell.swift
//  TableViewTest
//
//  Created by Matt Levan on 2/14/15.
//  Copyright (c) 2015 Matt Levan. All rights reserved.
//

import UIKit

class LexiconCell: UITableViewCell {

    @IBOutlet weak var LexiconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(imageName: String) {
        self.LexiconImage.image = UIImage(named: imageName)
    }
}
