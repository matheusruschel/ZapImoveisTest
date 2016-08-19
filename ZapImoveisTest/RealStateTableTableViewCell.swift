//
//  RealStateTableTableViewCell.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/18/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

class RealStateTableTableViewCell: UITableViewCell {

    @IBOutlet weak var labelAVenda: UILabel!
    @IBOutlet weak var labelAVendaPrice: UILabel!
    @IBOutlet weak var labelLocacao: UILabel!
    @IBOutlet weak var labelLocacaoPrice: UILabel!
    
    @IBOutlet weak var buttonEye: UIButton!
    @IBOutlet weak var buttonTrashCan: UIButton!
    
    @IBOutlet weak var imageViewRealState: UIImageView!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelStreet: UILabel!
    
    @IBOutlet weak var imageViewIconMessage: UIImageView!
    @IBOutlet weak var imageViewIconExpirationDate: UIImageView!
    
    @IBOutlet weak var labelMsgs: UILabel!
    
    @IBOutlet weak var labelExpirationDate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
