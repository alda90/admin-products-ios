//
//  CeldasGralesTableViewCell.swift
//  Admin-Products
//
//  Created by Aldair Carrillo on 09/11/20.
//  Copyright © 2020 Aldair Carrillo. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CeldasGralesTableViewCell: UITableViewCell {
    

    /////////////////////////   REQUISITOS TEXT
    
    
    
    @IBOutlet weak var viewContentParamterText: UIView!
    @IBOutlet weak var txtParameterText: SkyFloatingLabelTextField!
    @IBOutlet weak var imgParameterText: UIImageView!
    @IBOutlet weak var lblObservacionesText: UILabel!
    @IBOutlet weak var widthImgParameterText: NSLayoutConstraint!
    
    /////////////////////////  REQUISITOS FILES
    
    
    @IBOutlet weak var viewContentParameterFile: UIView!
    @IBOutlet weak var imgParameterFile: UIImageView!
    @IBOutlet weak var lblParameterFile: UILabel!
    @IBOutlet weak var lblObservacionesFile: UILabel!
    @IBOutlet weak var btnParameterFile: appButton!
    
    
    ////// ////  PRODUCTS
    
    @IBOutlet weak var lblNombreParametro: UILabel!
    @IBOutlet weak var lblParametro: UILabel!
    @IBOutlet weak var lblNombreSegundoParametro: UILabel!
    @IBOutlet weak var lblSegundoParametro: UILabel!
    @IBOutlet weak var viewContentProducts: UIView!
    
    
    //////////    CATALOGOS
    
    
    @IBOutlet weak var viewCatalogo: UIView!
    @IBOutlet weak var lblCatalogo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
