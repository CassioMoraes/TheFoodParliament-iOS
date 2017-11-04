//
//  RestaurantTableViewCell.swift
//  TheFoodParlament
//
//  Created by Cassio Moraes on 26/02/17.
//  Copyright © 2017 Cassio Moraes. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

	@IBOutlet weak var restaurantNameLabel: UILabel!
	@IBOutlet weak var restaurantAddressLabel: UILabel!
	@IBOutlet weak var totalDailyVotesLabel: UILabel!
	@IBOutlet weak var voteSwitch: UISwitch!
	
	var votedCallback: ((_ isOn: Bool) -> Void)?
	var restaurantId: String = String()
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
	
	@IBAction func voteSwitch(_ sender: UISwitch) {
		if let votedCallback = self.votedCallback {
			votedCallback(sender.isOn)
		}
	}
}
