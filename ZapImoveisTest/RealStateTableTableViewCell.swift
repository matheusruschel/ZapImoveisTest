//
//  RealStateTableTableViewCell.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/18/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

class RealStateTableTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonEye: UIButton! 
    @IBOutlet weak var buttonTrashCan: UIButton!
    @IBOutlet weak var imageViewRealState: CustomImageView!
    @IBOutlet weak var labelAVenda: UILabel! {
        didSet {
            configureLabel(labelAVenda)
        }
    }
    @IBOutlet weak var labelAVendaPrice: UILabel! {
        didSet {
            configureLabel(labelAVendaPrice)
        }
    }
    @IBOutlet weak var labelLocacao: UILabel! {
        didSet {
            configureLabel(labelLocacao)
        }
    }
    @IBOutlet weak var labelLocacaoPrice: UILabel! {
        didSet {
            configureLabel(labelLocacaoPrice)
        }
    }
    @IBOutlet weak var labelNumber: UILabel! {
        didSet {
            configureLabel(labelNumber)
        }
    }
    @IBOutlet weak var labelName: UILabel! {
        didSet {
            configureLabel(labelName)
        }
    }
    @IBOutlet weak var labelStreet: UILabel! {
        didSet {
            configureLabel(labelStreet)
        }
    }
    var activityIndicator:UIActivityIndicatorView!
    
    var imovel:Imovel? {
        didSet {
            fillInfo(imovel!)
        }
    }
    
    func fillInfo(imovel:Imovel) {
        
        if let precoVenda = imovel.precoVenda {
            labelAVenda.text = "À VENDA"
            labelAVendaPrice.text = "R$ \(precoVenda)"
        }
        
        if let precoAluguel = imovel.precoLocacao {
            labelLocacao.text = "LOCAÇÃO"
            labelLocacaoPrice.text = "R$ \(precoAluguel)"
        }
        
        labelNumber.text = "[\(imovel.codImovel!)]"
        labelName.text = "- \(imovel.tipoImovel!)"
        
        labelStreet.text = "\(imovel.endereco!.logradouro!) - \(imovel.endereco!.bairro!)"
        
        if let foto = imovel.getPreferredPhoto() {
            if let fotoURL = foto.imageURL {
                let imageDownloader = FotoDownloader()
                imageDownloader.fetchImage(fotoURL, completion: {
                
                    imageCallBack in
                    
                    do {
                        let image = try imageCallBack()
                        dispatch_async(dispatch_get_main_queue(), {
                            if let image = image {
                                self.imageViewRealState.image = image
                            } else {
                                self.imageViewRealState.image = nil
                            }
                        })
                    } catch let error {
                        print(error)
                    }
                    
                    self.activityIndicator?.stopAnimating()
                    
                })
            }
        }
        
    }
    
    func configureLabel(label:UILabel) {
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.whiteColor()
    }
    
    func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        self.addSubview(activityIndicator!)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
    }
    
    func clean() {
        
        labelAVendaPrice.text = ""
        labelLocacaoPrice.text = ""
        labelNumber.text = ""
        labelName.text = ""
        labelStreet.text = ""
        labelLocacao.text = ""
        labelAVenda.text = ""
        self.imageViewRealState.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clean()
        configureActivityIndicator()
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


