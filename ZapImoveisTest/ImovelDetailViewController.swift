//
//  ImovelDetailViewController.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import UIKit

class ImovelDetailViewController: UIViewController {

    
    @IBOutlet weak var imageViewImovel: CustomImageView!
    @IBOutlet weak var labelPrecoVenda: UILabel!
    @IBOutlet weak var labelPrecoVendaQuantidade: UILabel!
    @IBOutlet weak var labelTipoImovel: UILabel!
    @IBOutlet weak var labelPrecoLocacaoText: UILabel!
    @IBOutlet weak var labelPrecoLocacao: UILabel!
    @IBOutlet weak var labelQuartos: UILabel!
    @IBOutlet weak var labelBanheiro: UILabel!
    @IBOutlet weak var labelCarro: UILabel!
    @IBOutlet weak var labelMetrosQuadrados: UILabel!
    @IBOutlet weak var labelEndereco: UILabel!
    @IBOutlet weak var labelEstado: UILabel!
    @IBOutlet weak var labelImagens: UILabel!
    @IBOutlet weak var buttonMaps: UIButton!
    @IBOutlet weak var buttonContato: UIButton!
    var activityIndictor:UIActivityIndicatorView!
    
    var imovelViewModel: ImovelViewModel? {
        didSet {
            imovelViewModel!.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        imovelViewModel?.fetchImovel()
    }
    
    // MARK: UI CONFIGURATION
    
    func prepareUI() {
        configureLabels()
        configureActivityIndicator()
        configureNavigationBar()
        configureButtons()
        clearContent()
    }
    
    func configureLabels() {
        labelPrecoVenda.adjustsFontSizeToFitWidth = true
        labelPrecoVendaQuantidade.adjustsFontSizeToFitWidth = true
        labelPrecoLocacaoText.adjustsFontSizeToFitWidth = true
        labelPrecoLocacao.adjustsFontSizeToFitWidth = true
        labelTipoImovel.adjustsFontSizeToFitWidth = true
        labelQuartos.adjustsFontSizeToFitWidth = true
        labelBanheiro.adjustsFontSizeToFitWidth = true
        labelCarro.adjustsFontSizeToFitWidth = true
        labelMetrosQuadrados.adjustsFontSizeToFitWidth = true
        labelEndereco.adjustsFontSizeToFitWidth = true
        labelEstado.adjustsFontSizeToFitWidth = true
        labelImagens.adjustsFontSizeToFitWidth = true
    }
    
    func configureActivityIndicator() {
        
        self.activityIndictor = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        self.activityIndictor.center = self.view.center
        self.activityIndictor.hidesWhenStopped = true
        self.view.addSubview(self.activityIndictor)
    }
    
    func configureButtons() {
        
        buttonContato.backgroundColor = UIColor.appOrangeColor()
        buttonContato.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
    
    func configureNavigationBar() {
        self.navigationController!.navigationBar.backgroundColor = UIColor.clearColor()        
    }
    
    // MARK: REFRESH VIEW
    
    func refreshImovelInfo() {
        
        if let precoVendaString = imovelViewModel?.precoVendaString {
            labelPrecoVenda.text = "PREÇO DE VENDA"
            labelPrecoVendaQuantidade.text = precoVendaString
        }
        
        if let precoLocacaoString = imovelViewModel?.precoLocacaoString {
            labelPrecoLocacaoText.text = "PREÇO DE LOCAÇÃO"
            labelPrecoLocacao.text = precoLocacaoString
        }
        
        labelTipoImovel.text = imovelViewModel?.tipoString
        labelQuartos.text = imovelViewModel?.dormitoriosString
        labelBanheiro.text = imovelViewModel?.suitesString
        labelCarro.text = imovelViewModel?.vagasString
        labelMetrosQuadrados.text = imovelViewModel?.areaString
        labelEndereco.text = imovelViewModel?.enderecoString
        labelEstado.text = imovelViewModel?.estadoString
        labelImagens.text = "1 de 20"
    }
    
    func clearContent() {
        labelPrecoVenda.text = ""
        labelPrecoLocacaoText.text = ""
        labelPrecoVendaQuantidade.text = ""
        labelPrecoLocacao.text = ""
        labelTipoImovel.text = ""
        labelQuartos.text = ""
        labelBanheiro.text = ""
        labelCarro.text = ""
        labelMetrosQuadrados.text = ""
        labelEndereco.text = ""
        labelEstado.text = ""
        labelImagens.text = ""

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ImovelDetailViewController : ImovelViewModelDelegate {
    
    func didFinishLoadingImovel(imoveisViewModel: ImovelViewModel, sucess: Bool, errorMsg: String?) {
        
        dispatch_async(dispatch_get_main_queue(), {
            if sucess {
                self.refreshImovelInfo()
                self.imovelViewModel!.fetchImovelImage()
            } else {
                print(errorMsg!)
            }
        })
        
    }
    
    func didFinishLoadingImage(imoveisViewModel: ImovelViewModel, image: UIImage?, errorMsg: String?) {
        
        dispatch_async(dispatch_get_main_queue(), {
            if let image = image {
                self.imageViewImovel.image = image
                self.activityIndictor.stopAnimating()
            } else {
                print(errorMsg!)
            }
        })
        
    }
}