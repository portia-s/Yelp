//
//  SwitchTableViewCell.swift
//  Yelp
//
//  Created by Portia Sharma on 9/24/17.
//

import UIKit

@objc protocol SwitchTableViewCellDelegate {
    @objc optional func switchCell(switchCell: SwitchTableViewCell, didChangeValue value: Bool)
}

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        onSwitch.addTarget(self, action: #selector(SwitchTableViewCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func switchValueChanged() {
        //propagate this event from this view to viewController via delegate
        //can elimimate "if" check and do delegate? instead of delegate!
        if delegate != nil {
            delegate!.switchCell?(switchCell: self, didChangeValue: onSwitch.isOn)
        }
    }
}
