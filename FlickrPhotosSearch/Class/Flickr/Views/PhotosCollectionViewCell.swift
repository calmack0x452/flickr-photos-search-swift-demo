//
//  PhotosCollectionViewCell.swift
//  FlickrPhotosSearch
//
//  Created by Mack Liu on 2020/3/8.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit
import SDWebImage

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func assignData(data: FlickrPhoto) {
        
        let imageURL = "https://farm\(data.farm_id!).staticflickr.com/\(data.server_id!)/\(data.image_id!)_\(data.secret!)_m.jpg"
        
        imageWidthConstraint.constant = self.frame.size.width
        imageLabel.text = data.name
        imageView.sd_setImage(with: URL.init(string: imageURL), completed: nil)
        //imageView.sd_setImage(with: URL.init(string: imageURL), placeholderImage: UIImage.init(named: "image"), options: .avoidAutoSetImage, completed: nil)
    }
}
