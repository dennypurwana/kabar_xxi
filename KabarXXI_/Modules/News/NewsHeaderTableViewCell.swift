//
//  HomeHeaderTableViewCell.swift
//  KabarXXI_
//
//  Created by Emerio-Mac2 on 14/04/19.
//  Copyright © 2019 Emerio-Mac2. All rights reserved.
//

import UIKit

class NewsHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet var imageNews: UIImageView!
    
    @IBOutlet var titleNews: UILabel!
    
    @IBOutlet var dateNews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
