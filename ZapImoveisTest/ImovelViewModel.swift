//
//  ImovelViewModel.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/20/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation
import UIKit

protocol ImovelViewModelDelegate {
    func didFinishLoadingImovel(imoveisViewModel:ImovelViewModel, sucess:Bool, errorMsg:String?)
    func didFinishLoadingImage(imoveisViewModel:ImovelViewModel, image:UIImage?, errorMsg:String?)
}

class ImovelViewModel {
    
    var delegate: ImovelViewModelDelegate?
    private let imoveisAPI = RealStateCommunicationModel()
    private let imageDownloader = FotoDownloader()
    var imovelId:           Int?
    var precoVendaString:   String?
    var precoLocacaoString: String?
    var tipoString:         String?
    var dormitoriosString:  String?
    var suitesString:       String?
    var vagasString:        String?
    var areaString:         String?
    var enderecoString:     String?
    var estadoString:       String?
    var numFotos:           String?
    private var imovel:     Imovel? {
        didSet {
            fillTextsForImovel(imovel)
        }
    }
    
    init(imovelId:Int) {
        self.imovelId = imovelId
    }
    
    func fillTextsForImovel(imovel:Imovel?) {
    
        if let imovel = imovel {
            
            if let precoVenda = imovel.precoVenda {
                precoVendaString = "R$ \(precoVenda.stringFormatedWithSepator)"
            } else {
                precoVendaString = nil
            }
            
            if let precoLocacao = imovel.precoLocacao {
                precoLocacaoString = "R$ \(precoLocacao.stringFormatedWithSepator)"
            } else {
                precoLocacaoString = nil
            }
            
            tipoString = imovel.tipoImovel!
            suitesString = String(imovel.banheiros!)
            dormitoriosString = String(imovel.numeroQuartos!)
            vagasString = String(imovel.numeroGaragens!)
            areaString = String(imovel.metrosQuadrados!)
            numFotos = "1 de \(imovel.fotos!.count)"
            
            if let logradouro = imovel.endereco!.logradouro {
                enderecoString = logradouro
            }
            
            if let bairro = imovel.endereco!.bairro {
                if bairro != "" {
                    if enderecoString != ""  {
                        enderecoString = "\(enderecoString!) - \(bairro)"
                    } else {
                        enderecoString = bairro
                    }
                }
            }
            
            if let cidade = imovel.endereco!.cidade {
                estadoString = cidade
            }
            
            if let estado = imovel.endereco!.estado {
                if estado != "" {
                    if estadoString != "" {
                        estadoString = "\(estadoString!) - \(estado)"
                    } else {
                        estadoString = estado
                    }
                }
                
            }
            
        }
        
    }
    
    func fetchImovel() {
    
        imoveisAPI.fetchImovel(forId: self.imovelId!, completion: {
        
            imoveisResponse in
            
            do {
                let callBackStatus = try imoveisResponse()
                
                switch callBackStatus {
                case .ResponseObjectImovel(let imovel): self.imovel = imovel
                }
                
                self.delegate?.didFinishLoadingImovel(self, sucess: true, errorMsg: nil)
                
            }catch Error.ErrorWithMsg(let msg) {
                self.delegate?.didFinishLoadingImovel(self, sucess: false, errorMsg: msg)
            } catch {
                self.delegate?.didFinishLoadingImovel(self, sucess: false, errorMsg: "Erro ao buscar imóvel")
            }

        
        
        })
        
        
    }
    
    func fetchImovelImage() {
        
        if let imovel = imovel {
            
            imageDownloader.fetchImage(imovel.getPreferredPhoto()!.imageURL!, completion: {
                image in
                
                
                do {
                    let imageOptional = try image()
                    
                    if let imageUw = imageOptional {
                        
                        self.delegate?.didFinishLoadingImage(self, image: imageUw, errorMsg: nil)
                        
                    } else {
                        self.delegate?.didFinishLoadingImage(self, image: nil, errorMsg: "Erro ao buscar imagem")
                    }
                    
                } catch {
                    self.delegate?.didFinishLoadingImage(self, image: nil, errorMsg: "Erro ao buscar imagem")
                }
            
            })
        } else {
            self.delegate?.didFinishLoadingImage(self, image: nil, errorMsg: "Erro ao buscar imagem")
        }
        
        
        
    }
    
    
}