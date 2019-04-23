//
//  VideoCollectionViewCell.swift
//  KabarXXI_
//
//  Created by Emerio-Mac2 on 22/04/19.
//  Copyright © 2019 Emerio-Mac2. All rights reserved.
//

import UIKit
import Kingfisher

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var duration: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: Video) {
       
        let imageUrl = Constant.ApiUrlLocal+"/images/\(model.thumbnail)"
        thumbnail.kf.setImage(with: URL(string: imageUrl))
        title.text = model.title
        duration.text = model.duration
        
        
    }
    
}
