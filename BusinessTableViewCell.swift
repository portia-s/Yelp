//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Portia Sharma on 9/24/17.
//

import UIKit
import AFNetworking


class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    //set the properties of the BTVCell from Model
    var business: Business! {
        didSet {
            thumbImageView.setImageWith(business.imageURL!)
            nameLabel.text = business.name
            distanceLabel.text = business.distance
            addressLabel.text = business.address
            categoriesLabel.text = business.categories
            reviewsCountLabel.text = "\(business.reviewCount!)Reviews"
            ratingImageView.setImageWith(business.ratingImageURL!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //curve the edges
        thumbImageView.layer.cornerRadius = 4
        thumbImageView.clipsToBounds = true
        //label should wrap around actual label size
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        
    }
    
    //do again when orientation changes: wrapping nameLabel with size
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
