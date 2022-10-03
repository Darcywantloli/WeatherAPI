//
//  SearchPageTableViewCell.swift
//  weatherAPI
//
//  Created by Hung-Ming Chen on 2022/9/26.
//

import UIKit

class SearchPageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityName.font = cityName.font.withSize(40)
        cityName.textAlignment = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
